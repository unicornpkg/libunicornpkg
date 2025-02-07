package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

describe("core", function()
   it("require('unicorn.core') returns a table", function()
     expect(require("unicorn.core")):type("table")
   end)
end)