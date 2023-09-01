--- Utility functions for use with unicornpkg.
-- @module unicorn.util
package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local stdlib = require("libcompat")
local unicorn = {}
unicorn.util = {}

local http = http
local fs = fs
if _HOST:find("Recrafted") then -- Recrafted support
	http = require("http")
	fs = require("fs")
end

-- @description Returns contents of HTTP(S) request
-- @deprecated "Use http.get instead"
-- @param url string A valid HTTP or HTTPS URL.
function unicorn.util.smartHttp(url)
	print("Connecting to " .. url .. "... ")
	local response, httpError = stdlib.http.get(url)

	if response then
		print("HTTP success.")

		local sResponse = response.readAll()
		response.close()
		return sResponse
	else
		return false, httpError
	end
end

-- @description Writes a file to the specified path.
-- @param content string The contents of the file to be written.
-- @param path string The full path of the file to be written.
function unicorn.util.fileWrite(content, path)
	if content then -- Checking to m @ake sure content is there, to prevent writing an empty file
		local file1 = stdlib.fs.open(path, "w")
		file1.write(content)
		file1.flush()
	else
		return false
	end
end

return unicorn.util
