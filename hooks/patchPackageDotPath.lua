local function patchPackageDotPath(file)
	local f = fs.open(file, "r")
	local patch = 'package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path'

	local output = patch .. "\n" .. fs.readAll()
	f.close()
	local f = fs.open(file, "w")
	f.write(output)
	f.close()
end

local tArgs = {...}

assert(type(tArgs[1]), "string")
patchPackageDotPath(tArgs[1])
