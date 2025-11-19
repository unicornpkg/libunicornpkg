package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

local testutils = require("testutils")

describe("provider.org.softwareheritage.archive", function()
	testutils.checkPackageProviderIsWellFormed(it, "org.softwareheritage.archive")
	it("can be installed and uninstalled", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "org.softwareheritage.archive"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "org-softwareheritage-archive-test"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.instdat.filemaps = {}
		local long_swhid = [[swh:1:cnt:a5b86d1b8bda4040da84c67cbb4ae127d6141a4c]]
		thisPackage.instdat.filemaps[long_swhid] = "/lib/org-softwareheritage-archive-test.lua"

		testutils.doPackageProviderInstall(except, thisPackage)
	end)
end)
