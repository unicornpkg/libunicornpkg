package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

describe("util", function()
   it("require('unicorn.util') returns a table", function()
     expect(require("unicorn.util")):type("table")
   end)
end)
