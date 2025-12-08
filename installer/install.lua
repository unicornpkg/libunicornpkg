-- Main installer script for unicornpkg.
-- Installs install.lua.sfx, then installs components that you probably want.

fs.makeDir("/tmp")
shell.run(
	"wget https://github.com/unicornpkg/libunicornpkg/releases/latest/download/install.lua.sfx /tmp/install.lua.sfx"
)
shell.run("/tmp/install.lua.sfx /")
shell.run("rm /tmp/install.lua.sfx")

package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")

unicorn.core.install(
	unicorn.util.evaluateInSandbox(
		unicorn.util.smartHttp("https://unicornpkg.github.io/unicornpkg-main/unicorn-remote-main.lua")
	)()
)

unicorn.remote.install("semver")
unicorn.remote.install("ccryptolib")
unicorn.remote.install("unicorn-cli")

print("Thank you! unicornpkg is done installing!")
print("If you use and enjoy unicornpkg, consider giving us a star on GitHub:")
print("https://github.com/unicornpkg/libunicornpkg")
print("It helps the maintainer(s) know that they should keep developing this project.")

