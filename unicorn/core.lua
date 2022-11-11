--- A modular package manager.
-- @module unicorn.core

local unicorn = {}
unicorn.core = {}
unicorn.util = dofile("/lib/unicorn/util.lua")
unicorn.semver = dofile("/lib/unicorn/semver.lua")

-- better handling of globals with Lua diagnostics
-- @diagnostic disable:undefined-global
local fs = fs
local textutils = textutils
-- @diagnostic enable:undefined-global

if _HOST:find("Recrafted") then -- Recrafted support
	fs = require("fs")
	textutils = require("textutils")
end

local function is_installed(package_name)
		if fs.exists("/etc/unicorn/packages/installed/" .. package_name) then
			return true
		else
			return false
		end
end

--- Stores a package table at '/etc/unicorn/packages/installed/{package_name}' with 'textutils.serialise'.
-- @param package_table table A valid package table.
-- @return boolean
local function storePackageData(package_table)
	unicorn.util.fileWrite(textutils.serialise(package_table), "/etc/unicorn/packages/installed/" .. package_table.name)
	return is_installed(package_table.name)
end

--- Retrieves a package table stored at '/etc/unicorn/packages/installed/{package_name}' with 'textutils.unserialise'.
-- @param package_name string A valid name of a package.
-- @return table If the package table is present.
local function getPackageData(package_name)
	if is_installed(package_name) then
		local file1 = fs.open("/etc/unicorn/packages/installed/" .. package_name, "r")
		if file1 == nil then
			return false
		end
		return textutils.unserialise(file1.readAll())
	else
		return false
	end
end

--- Installs a package from a package table.
-- @param package_table table A valid package table
-- @return boolean
-- @return table
function unicorn.core.install(package_table)
	-- assertion blocks
	assert(package_table.unicornSpec, "This package is lacking the unicornSpec value. Installation was aborted as a precautionary measure.")
	if package_table.rel and package_table.rel.depends then
		for _, v in pairs(package_table.rel.depends) do
			assert(is_installed(v), package_table.name .. " requires the " .. v .. " package. Installation aborted.")
		end
	end

	-- skips installation if the package is already installed
	-- TODO: if we add package versions, this is where that logic should go
	local existing_package = getPackageData(package_table.name)
	if existing_package then
		if existing_package.version and package_table.version then
			if unicorn.semver(existing_package.version) == unicorn.semver(package_table.version) then
				error("Same version of package is installed. Uninstall the currently installed package if you want to override.")
			elseif unicorn.semver(existing_package.version) > unicorn.semver(package_table.version) then
				error("Newer version of package is installed. Uninstall the current package if you want to override.")
			elseif unicorn.semver(existing_package.version) < unicorn.semver(package_table.version) then
				unicorn.core.uninstall(existing_package.name)
			end
		end
	end
	
	-- modular provider loading and usage 
	local match
	for _, v in pairs(fs.list("/lib/unicorn/provider/")) do -- custom provider support
		local provider_name = string.gsub(v, ".lua", "")
		if package_table.pkgType == provider_name then
			match = true
			local provider = dofile("/lib/unicorn/provider/" .. v)
			provider(package_table)
		end
	end

	-- catch unknown providers
	if not match then
		if not package_table.pkgType == nil then
			error("Package provider " .. package_table.pkgType .. " is unknown. You are either missing the appropriate package provider or something is wrong with the package.")
		end
	end
	-- finish up
	storePackageData(package_table)
	print("Package " .. package_table.name .. " installed successfully.")
	return true, package_table
end

--- Removes a package from the system.
-- @param package_name string The name of a package.
-- @return boolean
function unicorn.core.uninstall(package_name)
	local package_table = getPackageData(package_name)
	for _, v in pairs(package_table.instdat.filemaps) do
		fs.delete(v)
	end
	fs.delete("/etc/unicorn/installed/" .. package_name)
	print("Package " .. package_name .. " removed.")
	return true
end

return unicorn.core

