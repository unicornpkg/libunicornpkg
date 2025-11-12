package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

describe("provider.org.bitbucket", function()
	it("require('unicorn.provider.org.bitbucket') returns a function", function()
		expect(require("unicorn.provider.org.bitbucket")):type("function")
	end)
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

		expect(unicornCore.install(thisPackage)):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/" .. thisPackage.name)):equals(true)
		expect(require(thisPackage.name)):equals(1)
		expect(unicornCore.uninstall(thisPackage.name)):equals(true)
	end)
end)
