package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

local testutils = require("testutils")

describe("provider.local.string", function()
	testutils.checkPackageProviderIsWellFormed(it, "local.generic")
	it("can be installed and uninstalled", function()
		local unicornCore = require("unicorn.core")
		--local testutils = require("testutils")

		local package = {}
		package.pkgType = "local.string"
		package.unicornSpec = "v1.0.0"
		package.name = "test-local.string"
		package.version = "0.0.1"
		package.instdat = {}
		package.instdat.filemaps = {}
		package.instdat.filemaps["return 1"] = "/lib/local-string-test-foo.lua"
		package.instdat.filemaps["return 2"] = "/lib/local-string-test-bar.lua"

		expect(unicornCore.install(package)):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/test-local.string")):equals(true)
		expect(require("local-string-test-foo")):equals(1)
		expect(require("local-string-test-bar")):equals(2)
		expect(unicornCore.uninstall("test-local.string")):equals(true)
	end)
end)
