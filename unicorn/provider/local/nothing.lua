package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
local unicorn = require("unicorn")

--- Package provider that does nothing.
local function install_nothing(...) end

return install_nothing
