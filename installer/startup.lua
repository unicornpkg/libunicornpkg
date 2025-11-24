package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")
unicorn.remote.install("commandcracker-sea")
unicorn.remote.install("semver")
unicorn.remote.install("ccryptolib")

fs.makeDir("/env/lib")
fs.copy("/lib/unicorn", "/env/lib/unicorn")

shell.run("/bin/ccsfx.lua env install.lua.sfx")
shell.run("install.lua.sfx test")

fs.makeDir("datapack/data/computercraft/lua/rom/modules")
fs.makeDir("datapack/data/computercraft/lua/rom/programs")
fs.makeDir("datapack/data/computercraft/lua/rom/autorun")
fs.makeDir("datapack/data/computercraft/lua/rom/config/unicorn")

fs.copy("/lib/unicorn", "datapack/data/computercraft/lua/rom/modules/unicorn")
fs.copy("/bin/hoof.lua", "datapack/data/computercraft/lua/rom/programs/hoof.lua")
fs.copy("/bin/unicorntool.lua", "datapack/data/computercraft/lua/rom/programs/unicorntool.lua")
fs.copy(
	"/source/extras/unix-path-bootstrap/unix-path-bootstrap.lua",
	"datapack/data/computercraft/lua/rom/autorun/unix-path-bootstrap.lua"
)
fs.copy(
	"/source/cli/unicorntool-completion.lua",
	"datapack/data/computercraft/lua/rom/autorun/unicorntool-completion.lua"
)
fs.copy("/source/cli/hoof-completion.lua", "datapack/data/computercraft/lua/rom/autorun/hoof-completion.lua")
fs.copy("/etc/unicorn/remotes/90-main.txt", "datapack/data/computercraft/lua/rom/config/unicorn/remotes/90_main.txt")

os.shutdown()
