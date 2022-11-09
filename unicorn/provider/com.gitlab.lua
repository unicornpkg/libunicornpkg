local unicorn = dofile("/lib/unicorn/init.lua")

--- Package provider for GitLab.com.
-- @param package_table table A valid package table
local function install_gitlab(package_table)
	for k, v in pairs(package_table.instdat.filemaps) do
		local http_data = unicorn.util.smartHttp("https://gitlab.com/raw/" .. package_table.instdat.repo_owner .. "/" .. package_table.instdat.repo_name .. "/" .. package_table.instdat.repo_ref .. "/" .. k)
		unicorn.util.fileWrite(http_data, v)
	end
end

return install_gitlab
