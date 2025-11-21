package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")

local tArgs = { ... }

local command = tArgs[1]
local target = tArgs[2]

if command == "install" or command == "add" then
	unicorn.remote.install(target)
elseif command == "uninstall" or command == "remove" then
	unicorn.core.uninstall(target)
end
