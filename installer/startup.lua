package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")
unicorn.remote.install("commandcracker-sea")
unicorn.remote.install("semver")
unicorn.remote.install("ccryptolib")

fs.makeDir("/env/lib")
fs.copy("/lib/unicorn", "/env/lib/unicorn")

shell.run("/bin/ccsfx.lua env install.lua.sfx")
shell.run("install.lua.sfx test")

os.shutdown()
