local unicorn = dofile("/lib/unicorn/init.lua")

--- Package provider for Bitbucket.org.
-- @param package_table table A valid package table
local function install_bitbucket(package_table)
	for remote_path, install_path in pairs(package_table.instdat.filemaps) do
		local http_data = unicorn.util.smartHttp(
			("https://bitbucket.org/%s/%s/raw/%s/%s"):format(
				package_table.instdat.repo_owner,
				package_table.instdat.repo_name,
				package_table.instdat.repo_ref,
				remote_path
			)
		)
		unicorn.util.fileWrite(http_data, install_path)
	end
end

return install_bitbucket
