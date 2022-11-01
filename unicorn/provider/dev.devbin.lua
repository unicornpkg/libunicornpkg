local unicorn = dofile("/lib/unicorn/init.lua")

--- Package provider for Devbin.dev.
-- @param package_table table A valid package table
local function install_devbin(package_table)
	for k,v in pairs(package_table.instdat.filemaps) do
		local http_data = unicorn.util.smartHttp("https://devbin.dev/raw/" .. k)
		unicorn.util.fileWrite(http_data, v)
	end
end

return install_devbin
