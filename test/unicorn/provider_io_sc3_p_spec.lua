package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

local testutils = require("testutils")

describe("provider.io.sc3.p", function()
	it("require('unicorn.provider.io.sc3.p') returns a function", function()
		expect(require("unicorn.provider.io.sc3.p")):type("function")
	end)
	it("can be installed and uninstalled", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "io.sc3.p"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "io-sc3-p-test"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.instdat.filemaps = {}
		thisPackage.instdat.filemaps["MvqH3FEeAx"] = "/lib/io-sc3-p-test.lua"

		testutils.doPackageProviderInstall(except, thisPackage)
	end)
end)
