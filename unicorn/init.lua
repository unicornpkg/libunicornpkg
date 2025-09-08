--- @namespace unicorn
package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = {}
unicorn.core = require("unicorn.core")
unicorn.util = require("unicorn.util")
unicorn.remote = require("unicorn.remote")

return unicorn
