package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")

--- Package provider for Pastebin.com.
---@param package_table table A valid package table
---@param state table A table containing locally-computed state
local function install_sc3_paste(state, package_table)
	for remote_path, install_path in pairs(package_table.instdat.filemaps) do
		local http_data = unicorn.util.smartHttp(("https://p.sc3.io/api/v1/pastes/%s/raw"):format(remote_path))
		state.filemaps[install_path] = http_data
	end
end

return install_sc3_paste
