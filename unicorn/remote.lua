--- Support for using package remotes.
-- @module unicorn.remote

package.path = package.path .. ";/lib/?;/lib/?.lua;/lib/?/init.lua;/rom/lib/?;/rom/lib/?.lua;/rom/lib/?/init.lua"

local unicorn = {}
unicorn.core = require("unicorn.core")
unicorn.util = require("unicorn.util")
unicorn.remote = {}

local function do_remote_install(package_name, v)
	local v = fs.open("/etc/unicorn/remotes/" .. v, "r")
	local v = v.readLine()
	local v = v:gsub("https://", "") -- have to remove the https:// prefix because fs.combine does weird stuff with it if it's left in
	local v = fs.combine(v, package_name .. ".lua")
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
		unicorn.core.install(loadstring(response)())

		downloaded = true
	end
end

function unicorn.remote.install(package_name)
	local downloaded = false
	while not downloaded do
		for _, v in pairs(fs.list("/rom/etc/unicorn/remotes/")) do
			do_remote_install(package_name, v)
		end
		for _, v in pairs(fs.list("/etc/unicorn/remotes/")) do
			do_remote_install(package_name, v)
		end

	end
end

return unicorn.remote

