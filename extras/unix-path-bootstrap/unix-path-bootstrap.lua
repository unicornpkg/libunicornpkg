if _HOST:find("Recrafted") then
	shell = require("shell")
	help = require("help")
end

if fs.exists("/bin") and fs.isDir("/bin") then
	shell.setPath(shell.path() .. ":/bin")
end
if fs.exists("/usr/share/help") and fs.isDir("/usr/share/help") then
	help.setPath(help.path() .. ":/usr/share/help")
end
