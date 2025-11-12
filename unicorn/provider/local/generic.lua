package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")

local provider = {}

--- Generic package provider.
---@param package_table table A valid package table
function provider.install(package_table)
	for remote_url, install_path in pairs(package_table.instdat.filemaps) do
		local http_data = unicorn.util.smartHttp(remote_url)
		unicorn.util.fileWrite(http_data, install_path)
	end
end

return provider
