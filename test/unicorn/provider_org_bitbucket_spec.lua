package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

local testutils = require("testutils")

describe("provider.org.bitbucket", function()
	testutils.checkPackageProviderIsWellFormed(it, "org.bitbucket")
	it("can be installed and uninstalled", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "org.bitbucket"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "org-bitbucket-test"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.instdat.repo_owner = "unicornpkg"
		thisPackage.instdat.repo_name = "test-repo"
		thisPackage.instdat.repo_ref = "f4dfa780eb0dd68bb2b9084feca5692971edd9fd"
		thisPackage.instdat.filemaps = {}
		thisPackage.instdat.filemaps["org-bitbucket-test.lua"] = "/lib/org-bitbucket-test.lua"

		testutils.doPackageProviderInstall(except, thisPackage)
	end)
end)
