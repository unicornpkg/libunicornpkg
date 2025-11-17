package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")

--- Package provider for git.launchpad.net.
---@param package_table table A valid package table
local function install_launchpad(package_table)
	for remote_path, install_path in pairs(package_table.instdat.filemaps) do
		local http_data = unicorn.util.smartHttp(
			("https://%s/%s/plain/%s?h=%s"):format(
				package_table.instdat.launchpad_instance or "git.launchpad.net",
				package_table.instdat.repo_name,
				remote_path,
				package_table.instdat.repo_ref
			)
		)
		unicorn.util.fileWrite(http_data, install_path)
	end
end

return install_launchpad
