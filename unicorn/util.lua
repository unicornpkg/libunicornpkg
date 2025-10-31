--- Utility functions for use with unicornpkg.

local unicorn = {}
--- !doctype module
--- @class unicorn.util
unicorn.util = {}

local http = http
local fs = fs
if _HOST:find("Recrafted") then -- Recrafted support
	http = require("http")
	fs = require("fs")
end

---@description Returns contents of HTTP(S) request
---@deprecated "Use http.get instead"
---@param url string A valid HTTP or HTTPS URL.
function unicorn.util.smartHttp(url)
	print("Connecting to " .. url .. "... ")
	local response, httpError = http.get(url)

	if response then
		print("HTTP success.")

		local sResponse = response.readAll()
		response.close()
		return sResponse
	else
		return false, httpError
	end
end

---@description Writes a file to the specified path.
---@param content string The contents of the file to be written.
---@param path string The full path of the file to be written.
function unicorn.util.fileWrite(content, path)
	if content then -- Checking to m @ake sure content is there, to prevent writing an empty file
		local file1 = fs.open(path, "w")
		file1.write(content)
		file1.flush()
	else
		return false
	end
end

unicorn.util.logging = {}

function unicorn.util.logging.error(...)
	error(...)
end

function unicorn.util.logging.warning(...)
	printError(...)
end

function unicorn.util.logging.info(...)
	print(...)
end

function unicorn.util.logging.debug(...)
	if _G.UNICORN_DEBUG == 1 then
		print(...)
	end
end

return unicorn.util
