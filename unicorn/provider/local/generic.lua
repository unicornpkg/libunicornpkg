package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")

--- Generic package provider.
---@param package_table table A valid package table
---@param state table A table containing locally-computed state
local function install_generic(state, package_table)
	for remote_url, install_path in pairs(package_table.instdat.filemaps) do
		local http_data = unicorn.util.smartHttp(remote_url)
		state.filemaps[install_path] = http_data
	end
end

return install_generic
