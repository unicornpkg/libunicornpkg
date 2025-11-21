describe("unicorntool", function()
	it("can install a package from a file", function()
		local unicornCore = require("unicorn.core")
		expect(shell.run("/bin/unicorntool install source/test/data/unicorntool-install-test-package.lua")):equals(true)

		expect(fs.exists("/etc/unicorn/packages/installed/unicorntool-install-test")):equals(true)
		expect(require("unicorntool-install-test")):equals(1)
		unicornCore.uninstall("unicorntool-install-test")
	end)
	it("can uninstall a package", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "local.string"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "unicorntool-uninstall-test"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.instdat.filemaps = {}
		thisPackage.instdat.filemaps["return 1"] = "/lib/unicorntool-uninstall-test.lua"

		unicornCore.install(thisPackage)
		expect(shell.run("/bin/unicorntool uninstall unicorntool-uninstall-test")):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/unicorntool-uninstall-test")):equals(false)
		expect.error(require, "unicorntool-uninstall-test")
	end)
	it("can have its subcommands be autocompleted", function()
		expect(shell.complete("bin/unicorntool.lua in")[1]):equals("stall")
		expect(shell.complete("bin/unicorntool.lua unin")[1]):equals("stall")
	end)
end)
