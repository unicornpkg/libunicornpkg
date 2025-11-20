package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")

--- Package provider for archive.org.
---@param package_table table A valid package table
---@param state table A table containing locally-computed state
local function install_ia(state, package_table)
	for remote_path, install_path in pairs(package_table.instdat.filemaps) do
		local http_data = unicorn.util.smartHttp(
			("https://archive.org/download/%s/%s"):format(package_table.instdat.item_name, remote_path)
		)
		state.filemaps[install_path] = http_data
	end
end

return install_ia
