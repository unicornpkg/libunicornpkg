package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")

--- Package provider for git.launchpad.net.
---@param package_table table A valid package table
---@param state table A table containing locally-computed state
local function install_launchpad(state, package_table)
	for remote_path, install_path in pairs(package_table.instdat.filemaps) do
		local http_data = unicorn.util.smartHttp(
			("https://%s/%s/plain/%s?h=%s"):format(
				package_table.instdat.launchpad_instance or "git.launchpad.net",
				package_table.instdat.repo_name,
				remote_path,
				package_table.instdat.repo_ref
			)
		)
		state.filemaps[install_path] = http_data
	end
end

return install_launchpad
