package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

describe("provider.org.bitbucket", function()
	it("require('unicorn.provider.local.generic') returns a function", function()
		expect(require("unicorn.provider.local.generic")):type("function")
	end)
	it("can be installed and uninstalled", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "local.generic"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "local-generic-test"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.instdat.filemaps = {}
		thisPackage.instdat.filemaps["https://unicornpkg.github.io/test-repo/local-generic-test.lua"] =
			"/lib/local-generic-test.lua"

		expect(unicornCore.install(thisPackage)):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/" .. thisPackage.name)):equals(true)
		expect(require(thisPackage.name)):equals(1)
		expect(unicornCore.uninstall(thisPackage.name)):equals(true)
	end)
end)
