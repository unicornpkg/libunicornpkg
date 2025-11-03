package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

describe("provider.local.string", function()
   it("require('unicorn.provider.local.string') returns a function", function()
     expect(require("unicorn.provider.local.string")):type("function")
   end)
end)
