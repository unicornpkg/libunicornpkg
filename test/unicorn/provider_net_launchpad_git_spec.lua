package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

local testutils = require("testutils")

describe("provider.net.launchpad.git", function()
	it("require('unicorn.provider.net.launchpad.git') returns a function", function()
		expect(require("unicorn.provider.com.github")):type("function")
	end)
	it("can be installed and uninstalled", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "net.launchpad.git"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "test-net-launchpad-git"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.instdat.repo_name = "unicornpkg-test-repo"
		thisPackage.instdat.repo_ref = "acbf30713ceced6586900fed835f05e23679853c"
		thisPackage.instdat.filemaps = {}
		thisPackage.instdat.filemaps["test-net-launchpad-git.lua"] = "/lib/test-net-launchpad-git.lua"

		testutils.doPackageProviderInstall(except, thisPackage)
	end)
end)
