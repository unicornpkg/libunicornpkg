package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local completion = require("cc.shell.completion")
local unicorn = require("unicorn")

local tArgs = { ... }

local command = tArgs[1]
local target = tArgs[2]

local function complete()
	shell.setCompletionFunction(
		shell.getRunningProgram(),
		completion.build({ completion.choice, { "install", "uninstall" } })
	)
	shell.setCompletionFunction(shell.getRunningProgram() .. " install", completion.build(completion.file))
end

complete()

if command == "install" or command == "add" then
	unicorn.remote.install(target)
elseif command == "uninstall" or command == "remove" then
	unicorn.core.uninstall(target)
end
