package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")

--- Package provider for Sourcehut.
---@param package_table table A valid package table
local function install_sourcehut(package_table)
	for remote_path, install_path in pairs(package_table.instdat.filemaps) do
		local http_data = unicorn.util.smartHttp(
			("https://%s/%s/%s/blob/%s/%s"):format(
				package_table.instdat.sourcehut_instance or "git.sr.ht",
				package_table.instdat.repo_owner,
				package_table.instdat.repo_name,
				package_table.instdat.repo_ref,
				remote_path
			)
		)
		unicorn.util.fileWrite(http_data, install_path)
	end
end

return install_sourcehut
