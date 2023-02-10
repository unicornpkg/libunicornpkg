package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")

--- Package provider for Pastebin.com.
-- @param package_table table A valid package table
local function install_pastebin(package_table)
	for remote_path, install_path in pairs(package_table.instdat.filemaps) do
		local http_data = unicorn.util.smartHttp(("https://pastebin.com/raw/%s"):format(remote_path))
		unicorn.util.fileWrite(http_data, install_path)
	end
end

return install_pastebin
