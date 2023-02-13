package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")

-- Package provider for GitHub Gists <gists.github.com>.
-- @param package_table table A valid package table
local function install_gist(package_table)
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
		unicorn.util.fileWrite(http_data, install_path)
	end
end

return install_gist
