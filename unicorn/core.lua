--- A modular package manager.
-- @author Tomodachi94
-- @copyright Copyright (c) 2022, MIT License. A copy of the license should have been distributed with the program. If not, see https://tomodachi94.mit-license.org online.
-- @module unicorn.core

local unicorn = {}
unicorn.core = {}
unicorn.util = dofile("/lib/unicorn/util.lua")

-- better handling of globals with Lua diagnostics
-- @diagnostic disable:undefined-global
local fs = fs
local http = http
local textutils = textutils
-- @diagnostic enable:undefined-global

--- Stores a package table at '/etc/unicorn/packages/installed/{package_name}' with 'textutils.serialise'.
-- @param package_table table A valid package table.
-- @return boolean
local function storePackageData(package_table)
	unicorn.util.fileWrite(textutils.serialise(package_table), "/etc/unicorn/packages/installed/"..package_table.name)
	if fs.exists("/etc/unicorn/packages/installed/"..package_table.name) then
		return true
	else
		return false
	end
end

--- Retrieves a package table stored at '/etc/unicorn/packages/installed/{package_name}' with 'textutils.unserialise'.
-- @param package_name string A valid name of a package.
-- @return table If the package table is present.
local function getPackageData(package_name)
	if fs.exists("/etc/unicorn/packages/installed/"..package_name) then
		local file1 = fs.open("/etc/unicorn/packages/installed/"..package_name, "r")
		if file1 == nil then
			return false
		end
		return textutils.unserialise(file1.readAll())
	else
		return false
	end
end

--- Package provider for GitHub.com.
-- @param package_table table A valid package table
local function install_github(package_table)
	for k,v in pairs(package_table.instdat.filemaps) do
		local http_data = unicorn.util.smartHttp("https://raw.githubusercontent.com/" .. package_table.instdat.repo_owner .."/".. package_table.instdat.repo_name .."/".. package_table.instdat.repo_ref .."/".. k)
		unicorn.util.fileWrite(http_data, v)
	end
end

--- Package provider for GitLab.com.
-- @param package_table table A valid package table
local function install_gitlab(package_table)
	for k,v in pairs(package_table.instdat.filemaps) do
		local http_data = unicorn.util.smartHttp("https://gitlab.com/raw/" .. package_table.instdat.repo_owner .."/".. package_table.instdat.repo_name .."/".. package_table.instdat.repo_ref .."/".. k)
		unicorn.util.fileWrite(http_data, v)
	end
end

--- Package provider for Bitbucket.org.
-- @param package_table table A valid package table
local function install_bitbucket(package_table)
	for k,v in pairs(package_table.instdat.filemaps) do
		local http_data = unicorn.util.smartHttp("https://bitbucket.org/raw/" .. package_table.instdat.repo_owner .."/".. package_table.instdat.repo_name .."/".. package_table.instdat.repo_ref .."/".. k)
		unicorn.util.fileWrite(http_data, v)
	end
end

--- Package provider for Devbin.dev.
-- @param package_table table A valid package table
local function install_devbin(package_table)
	for k,v in pairs(package_table.instdat.filemaps) do
		local http_data = unicorn.util.smartHttp("https://devbin.dev/raw/" .. k)
		unicorn.util.fileWrite(http_data, v)
	end
end

--- Package provider for Pastebin.com.
-- @param package_table table A valid package table
local function install_pastebin(package_table)
	for k,v in pairs(package_table.instdat.filemaps) do
		local http_data = unicorn.util.smartHttp("https://pastebin.com/raw/" .. k)
		unicorn.util.fileWrite(http_data, v)
	end
end

--- Package provider for GitHub Gists <gists.github.com>.
-- @param package_table table A valid package table
local function install_gist(package_table)
	-- this is really simple, only works predictably with a one-file gist.
	for k,v in pairs(package_table.instdat.filemaps) do
		-- uses source code repository-like names because a Gist is a repository technically :)
		local http_data = unicorn.util.smartHttp("https://gist.githubusercontent.com/" .. package_table.instdat.repo_owner .."/"..  package_table.instdat.repo_name .."/".. k .."/raw")
		unicorn.util.fileWrite(http_data, v)
	end
end

--- Installs a package from a package table.
-- @param package_table table A valid package table
-- @return boolean
-- @return table
function unicorn.core.install(package_table)
	if package_table.rel and package_table.rel.depends then
		for _,v in pairs(package_table.rel.depends) do
			if not fs.exists("/etc/unicorn/packages/installed/"..v) then
				error(package_table.name.." requires the "..v.." package. Aborting...")
			end
		end
	end
	if getPackageData(package_table.name) then
		return true, getPackageData(package_table.name)
	end
	if package_table.pkgType == "com.github" then
		install_github(package_table)
	elseif package_table.pkgType == "com.github.gist" then
		install_gist(package_table)
	elseif package_table.pkgType == "com.gitlab" then
		install_gitlab(package_table)
	elseif package_table.pkgType == "org.bitbucket" then
		install_bitbucket(package_table)
	elseif package_table.pkgType == "com.pastebin" then
		install_pastebin(package_table)
	elseif package_table.pkgType == "dev.devbin" then
		install_devbin(package_table)
	else
		if package_table.pkgType == nil then
			error("The provided package does not have a valid package type. This is either not a package or something is wrong with the file.")
		else
			error("Package type " .. package_table.pkgType .. " is unknown. You are either missing the appropriate package type or something is wrong with the package.")
		end
	end
	storePackageData(package_table)
	return true, package_table
end

--- Removes a package from the system.
-- @param package_name string The name of a package.
-- @return boolean
function unicorn.core.uninstall(package_name)
	local package_table = getPackageData(package_name)
	for _,v in pairs(package_table.instdat.filemaps) do
		fs.remove(v)
	end
	fs.remove("/etc/unicorn/installed/"..package_name)
	print("Package "..package_name.." removed.")
	return true
end

return unicorn.core

