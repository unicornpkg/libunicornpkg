--- Support for using package remotes.

package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = {}
unicorn.core = require("unicorn.core")
unicorn.util = require("unicorn.util")
--- Functions for installing packages from a package remote.
--- !doctype module
--- @class unicorn.remote
unicorn.remote = {}

---@return table
local function getConfiguredRemotes()
	local remotes = {}
	for _, filename in pairs(fs.list("/etc/unicorn/remotes/")) do
		local fullPath = "/etc/unicorn/remotes/" .. filename
		if (filename):match(".txt$") and (not fs.isDir(fullPath)) then
			local f = fs.open(fullPath, "r")
			local remoteUrl = f.readLine()
			f.close()
			table.insert(remotes, remoteUrl)
		end
	end
	return remotes
end

---@param remote_url string
---@param candidate string
---@return string
local function buildCandidateUrl(remote_url, candidate)
	local protocol_pattern = "^(%a+://)"
	local protocol = remote_url:match(protocol_pattern)
	-- remove the https:// prefix because fs.combine does weird stuff with it if it's left in
	local bare_remote_url = remote_url:gsub(protocol_pattern, "")
	local candidate_url = protocol .. fs.combine(bare_remote_url, candidate .. ".lua")
	return candidate_url
end

--- Installs a package from a remote.
---
--- This function traverses `/etc/unicorn/remotes` for all `.txt` files that contain URLs to a [package remote](https://unicornpkg.github.io/spec/v1.1.0/package-remotes.html).
---
--- For each remote, it tries requesting the remote's URL plus the package's name.
--- If it fails with a `Not Found` error, it moves on.
--- If it gets a good response, then it installs the package.
---
--- Example
--- ~~~~~~~
--- Installs MCJack123's AUKit, assuming a remote hosting it is configured.
--- >>> local unicorn = require("unicorn")
--- >>> unicorn.remote.install("aukit")
---@param package_name string The name of the package
---@return nil
function unicorn.remote.install(package_name)
	local downloaded = false
	while not downloaded do
		for _, remoteUrl in ipairs(getConfiguredRemotes()) do
			local candidateUrl = buildCandidateUrl(remoteUrl, package_name)
			-- FIXME: interface of smartHttp has changed significantly and now always errors
			-- migrate to bare http.get?
			local response, httpError = unicorn.util.smartHttp(candidateUrl)
			if httpError then
				if not httpError == "Not Found" then
					error("HTTP request to " .. candidateUrl .. " failed with error " .. httpError)
				end
			else
				unicorn.util.logging.debug(response)
				unicorn.util.logging.debug(httpError)

				local package_table = unicorn.util.evaluateInSandbox(response)()

				-- install depends
				if package_table.rel ~= nil and package_table.rel.depends ~= nil then
					for _, package in pairs(package_table.rel.depends) do
						unicorn.remote.install(package)
					end
				end

				unicorn.core.install(package_table)

				downloaded = true
			end
		end
	end
end

return unicorn.remote
