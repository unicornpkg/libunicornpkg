local function complete()
	local completion = require("cc.shell.completion")
	shell.setCompletionFunction(
		"bin/unicorntool.lua",
		completion.build({ completion.choice, { "install", "uninstall" } })
	)
end

complete()
