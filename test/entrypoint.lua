local files = fs.list("test")

--[[
for _, file in ipairs(files) do
    if file:sub(-4) == ".lua" then
        shell.run("test/" .. file)
    end
end
]]--

package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

local luaunit = require('luaunit')

TestArithmetic = require("/test/lorem")

local runner = luaunit.LuaUnit.new()
runner:setOutputType("tap")
runner:runSuite()

-- shell.run("/test/lorem", "test_addition")