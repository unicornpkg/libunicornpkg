package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")

local provider = {}

--- Package provider for Pastebin.com.
---@param package_table table A valid package table
function provider.install(package_table)
	for remote_path, install_path in pairs(package_table.instdat.filemaps) do
		local http_data = unicorn.util.smartHttp(("https://p.sc3.io/api/v1/pastes/%s/raw"):format(remote_path))
		unicorn.util.fileWrite(http_data, install_path)
	end
end

return provider
