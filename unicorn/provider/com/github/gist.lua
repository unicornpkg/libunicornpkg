package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")

-- Package provider for GitHub Gists <gists.github.com>.
---@param package_table table A valid package table
---@param state table A table containing locally-computed state
local function install_gist(state, package_table)
	-- this is really simple, only works predictably with a one-file gist.
	for remote_path, install_path in pairs(package_table.instdat.filemaps) do
		-- uses source code repository-like names because a Gist is a repository technically :)
		local http_data = unicorn.util.smartHttp(
			("https://gist.githubusercontent.com/%s/%s/raw/%s/%s"):format(
				package_table.instdat.repo_owner,
				package_table.instdat.repo_name,
				package_table.instdat.repo_ref,
				remote_path
			)
		)
		state.filemaps[install_path] = http_data
	end
end

return install_gist
