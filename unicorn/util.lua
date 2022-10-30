--- Utility functions for use with unicornpkg.
local unicorn = {}
unicorn.util = {}

-- @description Returns contents of HTTP(S) request
-- @param sUrl string A valid HTTP or HTTPS URL.
function unicorn.util.smartHttp(sUrl)
	print("Connecting to " .. sUrl .. "... ")
	local response, httpError = http.get(sUrl)

	if response then
		print("HTTP success.")

		local sResponse = response.readAll()
		response.close()
		return sResponse
	else
		error("HTTP failed: "..httpError)
		return false
	end
end

-- @description Writes a file to the specified path.
-- @param sContent string The contents of the file to be written.
-- @param sPath string The full path of the file to be written.
function unicorn.util.fileWrite(sContent, sPath)
	if sContent then -- Checking to make sure content is there, to prevent writing an empty file
		local file1 = fs.open(sPath, "w")
		file1.write(sContent)
		file1.flush()
	else
		return false
	end
end

return unicorn.util
