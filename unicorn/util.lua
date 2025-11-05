--- Utility functions for use with unicornpkg.

local unicorn = {}
--- !doctype module
--- @class unicorn.util
unicorn.util = {}

---@description Returns contents of HTTP(S) request
---@deprecated "Use http.get instead"
---@param url string A valid HTTP or HTTPS URL.
function unicorn.util.smartHttp(url)
	unicorn.util.logging.debug("Connecting to " .. url .. "... ")

	local response, httpError = http.get(url)
	if not response then
		error("Failed to fetch URL '" .. url .. "': " .. tostring(httpError))
	end

	unicorn.util.logging.debug("HTTP success.")
	local sResponse = response.readAll()
	response.close()
	return sResponse
end

---@description Writes a file to the specified path.
---@param content string The contents of the file to be written.
---@param path string The full path of the file to be written.
function unicorn.util.fileWrite(content, path)
	if content then -- Checking to m @ake sure content is there, to prevent writing an empty file
		local file1 = fs.open(path, "w")
		file1.write(content)
		file1.close()
	else
		return false
	end
end

--- A table containing "safe" functions that have no side effects outside of where they are used.
---@see unicorn.util.evaluateInSandbox
---@type table
--- @doctype const
unicorn.util.sandbox_env = {
	-- Source: https://stackoverflow.com/a/6982080 (with gentle modifications)
	ipairs = ipairs,
	next = next,
	pairs = pairs,
	tonumber = tonumber,
	tostring = tostring,
	type = type,
	unpack = unpack,
	string = {
		byte = string.byte,
		char = string.char,
		find = string.find,
		format = string.format,
		gmatch = string.gmatch,
		gsub = string.gsub,
		len = string.len,
		lower = string.lower,
		match = string.match,
		rep = string.rep,
		reverse = string.reverse,
		sub = string.sub,
		upper = string.upper,
	},
	table = { insert = table.insert, maxn = table.maxn, remove = table.remove, sort = table.sort },
	math = {
		abs = math.abs,
		acos = math.acos,
		asin = math.asin,
		atan = math.atan,
		atan2 = math.atan2,
		ceil = math.ceil,
		cos = math.cos,
		cosh = math.cosh,
		deg = math.deg,
		exp = math.exp,
		floor = math.floor,
		fmod = math.fmod,
		frexp = math.frexp,
		huge = math.huge,
		ldexp = math.ldexp,
		log = math.log,
		log10 = math.log10,
		max = math.max,
		min = math.min,
		modf = math.modf,
		pi = math.pi,
		pow = math.pow,
		rad = math.rad,
		sin = math.sin,
		sinh = math.sinh,
		sqrt = math.sqrt,
		tan = math.tan,
		tanh = math.tanh,
	},
}

--- Load some Lua code in a sandboxed environment.
--- Scripts have access to any variable defined in :ref:`unicorn.util.sandbox_env`.
---@see load
---@param input string Lua code to evaluate
---@return function
function unicorn.util.evaluateInSandbox(input)
	return load(input, "sandbox_content", "t", unicorn.util.sandbox_env)
end

--- !doctype module
--- @class unicorn.util.logging
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
	-- selene: allow(global_usage)
	if _G.UNICORN_DEBUG_DO_NOT_USE_IN_PRODUCTION_CODE == 1 then
		print(...)
	end
end

return unicorn.util
