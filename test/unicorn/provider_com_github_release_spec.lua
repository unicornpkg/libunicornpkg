package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

local testutils = require("testutils")

describe("provider.com.github.release", function()
	testutils.checkPackageProviderIsWellFormed(it, "com.github.release")
	it("can be installed and uninstalled", function()
		local thisPackage = {}
		thisPackage.pkgType = "com.github.release"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "com-github-release-test"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.instdat.repo_owner = "unicornpkg"
		thisPackage.instdat.repo_name = "test-repo"
		thisPackage.instdat.repo_ref = "v" .. thisPackage.version
		thisPackage.instdat.filemaps = {}
		thisPackage.instdat.filemaps["com-github-release-test.lua"] = "/lib/com-github-release-test.lua"

		testutils.doPackageProviderInstall(except, thisPackage)
	end)
end)
