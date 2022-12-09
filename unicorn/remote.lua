--- Support for using package remotes.
-- @module unicorn.remote

local unicorn = {}
unicorn.core = dofile("/lib/unicorn/core.lua")
unicorn.util = dofile("/lib/unicorn/util.lua")
unicorn.remote = {}

function unicorn.remote.install(package_name)
	local downloaded = false
	while not downloaded do
		-- TODO: Change the variable names into something more descriptive
		-- TODO: Split this into smaller local functions
		for _, v in pairs(fs.list("/etc/unicorn/remotes/")) do
			v = fs.open("/etc/unicorn/remotes/" .. v, "r")
			v = v.readLine()
			v = v:gsub("https://", "") -- have to remove the https:// prefix because fs.combine does weird stuff with it if it's left in
			v = fs.combine(v, package_name .. ".lua")
			v = "https://" .. v
			local response, httpError = unicorn.util.smartHttp(v)
			if httpError then
				if not httpError == "Not Found" then
					error("HTTP request to " .. v .. " failed with error " .. httpError)
				end
			else
				unicorn.util.fileWrite(response, "/tmp/" .. package_name)
				print(response)
				print(httpError)

				local package_table = loadstring(response)()

				-- install depends
				if package_table.rel ~= nil and package_table.rel.depends ~= nil then
					for _, package in pairs(package_table.rel.depends) do
						unicorn.remote.install(package)
					end
				end

				unicorn.core.install(package_table)

				downloaded = true
			end
		end
	end
end

return unicorn.remote
