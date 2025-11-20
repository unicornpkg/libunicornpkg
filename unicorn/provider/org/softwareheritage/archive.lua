package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")

--- HACK: Get our graphql query from the current directory using debug.getinfo
---@return string
local function getQuery()
	local src = debug.getinfo(1, "S").source
	if src:sub(1, 1) == "@" then
		src = src:sub(2)
	end

	local dir = src:match("^(.*)/") or ""
	local path = fs.combine(dir, "FetchContentFromSWHID.graphql")
	local h = fs.open(path, "r")
	local data = h.readAll()
	h.close()
	return data
end

---@param swhid string SWHID starting with swh:1:cnt:, with the remainder being a hexadecimal string
---@return string
local function getSwhidContents(swhid)
	assert(
		string.match(swhid, "^swh:1:cnt:%x+"),
		"SWHID must start with 'swh:1:cnt:', with the remainder being a hexadecimal string"
	)

	local variables = {
		ourSwhid = swhid,
	}
	local query = getQuery()

	local body = textutils.serializeJSON({ query = query, variables = variables })
	unicorn.util.logging.debug("GraphQL request body is:")
	unicorn.util.logging.debug(body)
	local res, err = http.post("https://archive.softwareheritage.org/graphql/", body, {
		["Content-Type"] = "application/json",
		["User-Agent"] = unicorn.constants.userAgent,
	})

	if not res then
		error("HTTP request failed: " .. err)
	end

	local data = textutils.unserializeJSON(res.readAll())
	res.close()

	return data.data.file[1].data.raw.text
end

--- Package provider for Software Heritage.
---@param package_table table A valid package table
---@param state table A table containing locally-computed state
local function install_softwareheritage(state, package_table)
	for swhid, install_path in pairs(package_table.instdat.filemaps) do
		state.filemaps[install_path] = getSwhidContents(swhid)
	end
	return state
end

return install_softwareheritage
