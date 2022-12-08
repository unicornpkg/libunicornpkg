local unicorn = dofile("/lib/unicorn/init.lua")

--- Package provider for Devbin.dev.
-- @param package_table table A valid package table
-- @deprecated because devbin.dev has shut down.
local function install_devbin(package_table)
	for remote_path, install_path in pairs(package_table.instdat.filemaps) do
		local http_data = unicorn.util.smartHttp(("https://devbin.dev/raw/%s"):format(remote_path))
		unicorn.util.fileWrite(http_data, install_path)
	end
end

return install_devbin
