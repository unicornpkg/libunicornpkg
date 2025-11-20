package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")

--- Package provider for GitLab.com.
---@param package_table table A valid package table
---@param state table A table containing locally-computed state
local function install_gitlab(state, package_table)
	for remote_path, install_path in pairs(package_table.instdat.filemaps) do
		local http_data = unicorn.util.smartHttp(
			("https://%s/%s/%s/-/raw/%s/%s"):format(
				package_table.instdat.gitlab_instance or "gitlab.com",
				package_table.instdat.repo_owner,
				package_table.instdat.repo_name,
				package_table.instdat.repo_ref,
				remote_path
			)
		)
		state.filemaps[install_path] = http_data
	end
end

return install_gitlab
