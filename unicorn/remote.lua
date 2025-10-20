--- Support for using package remotes.

package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = {}
unicorn.core = require("unicorn.core")
unicorn.util = require("unicorn.util")
--- !doctype module
--- @class unicorn.remote
unicorn.remote = {}

--- Installs a package from a remote.
---
--- This function traverses `/etc/unicorn/remotes` for all text files that contain URLs to a [package remote](https://unicornpkg.github.io/spec/v1.1.0/package-remotes.html).
---
--- For each remote, it tries requesting the remote's URL plus the package's name.
--- If it fails with a `Not Found` error, it moves on.
--- If it gets a good response, then it installs the package.
--- ## Example
--- ```lua
--- local unicorn = require("unicorn")
--- unicorn.remote.install("aukit") -- installs MCJack123's AUKit, assuming the default remote is present
--- ```
function unicorn.remote.install(package_name)
	local downloaded = false
	while not downloaded do
		-- TODO: Change the variable names into something more descriptive
		-- TODO: Split this into smaller local functions
		for _, v0 in pairs(fs.list("/etc/unicorn/remotes/")) do
			if not fs.isDir("/etc/unicorn/remotes/" .. v0) then
				local v1 = fs.open("/etc/unicorn/remotes/" .. v0, "r")
				local v2 = v1.readLine()
				local v3 = v2:gsub("https://", "") -- have to remove the https:// prefix because fs.combine does weird stuff with it if it's left in
				local v4 = fs.combine(v3, package_name .. ".lua")
				local v5 = "https://" .. v4
				local response, httpError = unicorn.util.smartHttp(v5)
				if httpError then
					if not httpError == "Not Found" then
						error("HTTP request to " .. v5 .. " failed with error " .. httpError)
					end
				else
					unicorn.util.fileWrite(response, "/tmp/" .. package_name)
					print(response)
					print(httpError)

					local package_table = load(response)()

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
end

return unicorn.remote
