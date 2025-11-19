package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

local testutils = require("testutils")

describe("provider.io.sc3.p", function()
	testutils.checkPackageProviderIsWellFormed(it, "io.sc3.p")
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
