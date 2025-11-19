package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

local testutils = require("testutils")

describe("provider.local.nothing", function()
	testutils.checkPackageProviderIsWellFormed(it, "local.generic")
	it("ignores instdat if it is present", function()
		local unicornCore = require("unicorn.core")
		--local testutils = require("testutils")

		local package = {}
		package.pkgType = "local.nothing"
		package.unicornSpec = "v1.0.0"
		package.name = "argparse"
		package.version = "0.0.1"
		package.instdat = {}
		-- Some bogus data for instdat, to see if something goes wrong
		package.instdat.repo_owner = "Commandcracker"
		package.instdat.repo_name = "cc-argparse"
		package.instdat.repo_ref = "v0.7.2"
		package.instdat.filemaps = {}
		package.instdat.filemaps["argparse.min.lua"] = "/lib/argparse.lua"

		expect(unicornCore.install(package)):equals(true)
		expect(fs.exists("/lib/argparse.lua")):equals(false)
		expect(fs.exists("/etc/unicorn/packages/installed/argparse")):equals(true)
		expect(unicornCore.uninstall("argparse")):equals(true)
	end)
	it("can be installed and uninstalled if instdat is empty", function()
		local unicornCore = require("unicorn.core")
		--local testutils = require("testutils")

		local package = {}
		package.pkgType = "local.nothing"
		package.unicornSpec = "v1.0.0"
		package.name = "test-local.nothing-empty-instdat"
		package.version = "0.0.1"
		package.instdat = {}

		expect(unicornCore.install(package)):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/test-local.nothing-empty-instdat")):equals(true)
		expect(unicornCore.uninstall("test-local.nothing-empty-instdat")):equals(true)
	end)
end)
