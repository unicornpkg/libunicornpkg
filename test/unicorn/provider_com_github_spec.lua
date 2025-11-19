package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

local testutils = require("testutils")

describe("provider.com.github", function()
	it("require('unicorn.provider.com.github') returns a function", function()
		expect(require("unicorn.provider.com.github")):type("function")
	end)
	it("can be installed and uninstalled", function()
		local thisPackage = {}
		thisPackage.pkgType = "com.github"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "com-github-test"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.instdat.repo_owner = "unicornpkg"
		thisPackage.instdat.repo_name = "test-repo"
		thisPackage.instdat.repo_ref = "caaea67460e1c3b8e275d83500bb1100c3a1837c"
		thisPackage.instdat.filemaps = {}
		thisPackage.instdat.filemaps["com-github-test.lua"] = "/lib/com-github-test.lua"

		testutils.doPackageProviderInstall(except, thisPackage)
	end)
end)
