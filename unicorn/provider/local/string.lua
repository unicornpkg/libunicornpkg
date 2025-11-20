package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")

--- Generic package provider.
---@param package_table table A valid package table
---@param state table A table containing locally-computed state
local function install_string(state, package_table)
	for _string, install_path in pairs(package_table.instdat.filemaps) do
		state.filemaps[install_path] = _string
	end
	return state
end

return install_string
