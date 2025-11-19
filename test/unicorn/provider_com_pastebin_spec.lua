package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

local testutils = require("testutils")

describe("provider.com.pastebin", function()
	testutils.checkPackageProviderIsWellFormed(it, "com.pastebin")
	it("can be installed and uninstalled", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "com.pastebin"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "com-pastebin-test"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.instdat.filemaps = {}
		thisPackage.instdat.filemaps["21Qmqwa8"] = "/lib/com-pastebin-test.lua"

		testutils.doPackageProviderInstall(except, thisPackage)
	end)
end)
