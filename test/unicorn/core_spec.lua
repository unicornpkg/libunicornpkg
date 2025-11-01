package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

describe("core", function()
	it("require('unicorn.core') returns a table", function()
		expect(require("unicorn.core")):type("table")
	end)
	it("core.install runs script.preinstall", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "local.nothing"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "test-script-preinstall"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.script = {}
		thisPackage.script.preinstall = [[fs.makeDir("/tmp/test-core/preinstall-script")]]

		expect(fs.isDir("/tmp/test-core/preinstall-script")):equals(false)
		unicornCore.install(thisPackage)
		expect(fs.isDir("/tmp/test-core/preinstall-script")):equals(true)
		unicornCore.uninstall("test-script-preinstall")
		fs.delete("/tmp")
	end)
	it("core.install runs script.postinstall", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "local.nothing"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "test-script-postinstall"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.script = {}
		thisPackage.script.postinstall = [[fs.makeDir("/tmp/test-core/postinstall-script")]]

		expect(fs.isDir("/tmp/test-core/postinstall-script")):equals(false)
		unicornCore.install(thisPackage)
		expect(fs.isDir("/tmp/test-core/postinstall-script")):equals(true)
		unicornCore.uninstall("test-script-postinstall")
		fs.delete("/tmp")
	end)
	it("core.uninstall runs script.preremove", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "local.nothing"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "test-script-preremove"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.script = {}
		thisPackage.script.preremove = [[fs.makeDir("/tmp/test-core/preremove-script")]]

		expect(fs.isDir("/tmp/test-core/preremove-script")):equals(false)
		unicornCore.install(thisPackage)
		expect(fs.isDir("/tmp/test-core/preremove-script")):equals(false)
		unicornCore.uninstall("test-script-preremove")
		expect(fs.isDir("/tmp/test-core/preremove-script")):equals(true)
		fs.delete("/tmp")
	end)
	it("core.uninstall runs script.postremove", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "local.nothing"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "test-script-postremove"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.script = {}
		thisPackage.script.postremove = [[fs.makeDir("/tmp/test-core/postremove-script")]]

		expect(fs.isDir("/tmp/test-core/postremove-script")):equals(false)
		unicornCore.install(thisPackage)
		expect(fs.isDir("/tmp/test-core/postremove-script")):equals(false)
		unicornCore.uninstall("test-script-postremove")
		expect(fs.isDir("/tmp/test-core/postremove-script")):equals(true)
		fs.delete("/tmp")
	end)
end)
