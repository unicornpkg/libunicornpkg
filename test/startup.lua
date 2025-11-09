package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")
unicorn.remote.install("semver")
unicorn.remote.install("anavrins-sha256")

_G.UNICORN_DEBUG_DO_NOT_USE_IN_PRODUCTION_CODE = 1
shell.run('bin/mcfly.lua source/test/unicorn/')
os.shutdown()