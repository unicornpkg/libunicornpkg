package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = {}
unicorn.core = require("unicorn.core")
unicorn.util = dofile("unicorn.util")
unicorn.remote = dofile("unicorn.remote")

return unicorn
