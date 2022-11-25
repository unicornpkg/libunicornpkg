package.path = package.path .. ";/lib/?;/lib/?.lua;/lib/?/init.lua;/rom/lib/?;/rom/lib/?.lua;/rom/lib/?/init.lua"

local unicorn = {}
unicorn.core = require("unicorn.core")
unicorn.util = require("unicorn.util")
unicorn.remote = require("unicorn.remote")
unicorn.semver = require("unicorn.semver")

return unicorn
