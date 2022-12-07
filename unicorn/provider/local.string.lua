local unicorn = dofile("/lib/unicorn/init.lua")

--- Generic package provider.
-- @param package_table table A valid package table
local function install_string(package_table)
	for _string, install_path in pairs(package_table.instdat.filemaps) do
		unicorn.util.fileWrite(_string, install_path)
	end
end

return install_string
