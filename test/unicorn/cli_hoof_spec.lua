describe("hoof", function()
	it("can install a package from a remote", function()
		local unicornCore = require("unicorn.core")
		expect(shell.run("/bin/hoof install string_pack")):equals(true)

		expect(fs.exists("/etc/unicorn/packages/installed/string_pack")):equals(true)
		expect(require("string_pack").pack):type("function")
		unicornCore.uninstall("string_pack")
	end)
	it("can uninstall a package", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "local.string"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "hoof-uninstall-test"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.instdat.filemaps = {}
		thisPackage.instdat.filemaps["return 1"] = "/lib/hoof-uninstall-test.lua"

		unicornCore.install(thisPackage)
		expect(shell.run("/bin/hoof uninstall hoof-uninstall-test")):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/hoof-uninstall-test")):equals(false)
		expect.error(require, "hoof-uninstall-test")
	end)
	it("can have its subcommands be autocompleted", function()
		expect(shell.complete("bin/hoof.lua in")[1]):equals("stall")
		expect(shell.complete("bin/hoof.lua unin")[1]):equals("stall")
	end)
end)
