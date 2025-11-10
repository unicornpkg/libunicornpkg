if _HOST:find("Recrafted") then
	shell = require("shell")
	help = require("help")
end

shell.setPath(shell.path() .. ":/bin")
help.setPath(help.path() .. ":/usr/share/help")
