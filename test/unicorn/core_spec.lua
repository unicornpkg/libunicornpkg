package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

local testutils = require("testutils")

describe("core", function()
	it("require('unicorn.core') returns a table", function()
		expect(require("unicorn.core")):type("table")
	end)

	it("unicorn.core.install fails when it encounters an unknown pkgType", function()
		local unicornCore = require("unicorn.core")
		local fake_provider_name = "invalid.this_package_provider_should_never_exist"

		local thisPackage = {}
		thisPackage.pkgType = fake_provider_name
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "test-fail-unknown-pkgType"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}

		local status = pcall(unicornCore.install, thisPackage)
		expect(status):equals(false)
	end)

	it("unicorn.core.install fails when it encounters a table without a unicornSpec value", function()
		local unicornCore = require("unicorn.core")
		local fake_provider_name = "invalid.this_package_provider_should_never_exist"

		local thisPackage = {}
		thisPackage.pkgType = fake_provider_name
		thisPackage.name = "test-fail-no-unicornSpec"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}

		local status = pcall(unicornCore.install, thisPackage)
		expect(status):equals(false)
	end)

	it("unicorn.core.install creates directories when dirs is set", function()
		local unicornCore = require("unicorn.core")
		local thisPackage = {}
		thisPackage.pkgType = "local.nothing"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "test-dirs-created"
		thisPackage.version = "0.0.1"
		thisPackage.dirs = { "/lib/giim" }

		expect(fs.isDir("/lib/giim")):equals(false)
		unicornCore.install(thisPackage)
		expect(fs.isDir("/lib/giim")):equals(true)
		unicornCore.uninstall("test-dirs-created")
	end)

	it("unicorn.core.uninstall deletes empty directories when dirs is set", function()
		local unicornCore = require("unicorn.core")
		local thisPackage = {}
		thisPackage.pkgType = "local.nothing"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "test-dirs-deleted"
		thisPackage.version = "0.0.1"
		thisPackage.dirs = { "/lib/giim" }

		expect(fs.isDir("/lib/giim")):equals(false)
		unicornCore.install(thisPackage)
		expect(fs.isDir("/lib/giim")):equals(true)
		unicornCore.uninstall("test-dirs-deleted")
		expect(fs.isDir("/lib/giim")):equals(false)
	end)

	it("unicorn.core.uninstall keeps directories containing stuff when dirs is set", function()
		local unicornCore = require("unicorn.core")
		local unicornUtil = require("unicorn.util")
		local thisPackage = {}
		thisPackage.pkgType = "local.nothing"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "test-dirs-preserved-when-containing-stuff"
		thisPackage.version = "0.0.1"
		thisPackage.dirs = { "/lib/giim" }

		expect(fs.isDir("/lib/giim")):equals(false)
		unicornCore.install(thisPackage)
		expect(fs.isDir("/lib/giim")):equals(true)
		unicornUtil.fileWrite("return 1", "/lib/giim/hello.lua")
		unicornCore.uninstall("test-dirs-preserved-when-containing-stuff")
		expect(fs.isDir("/lib/giim")):equals(true)
		expect(require("giim.hello")):equals(1)
	end)

	it("unicorn.core.install doesn't cause problems when hashes are good", function()
		local unicornCore = require("unicorn.core")

		local package = {}
		package.pkgType = "local.string"
		package.unicornSpec = "v1.0.0"
		package.name = "test-sha256-validated"
		package.version = "0.0.1"
		package.instdat = {}
		package.instdat.filemaps = {}
		package.instdat.filemaps["return 1"] = "/lib/test-sha256-validated.lua"
		package.security = {}
		package.security.sha256 = {}
		package.security.sha256["/lib/test-sha256-validated.lua"] =
			"486d9affb60dbb0063b03d8e23a6ccf6364ce203dc3a9f56f20e750eb41ecade"

		expect(unicornCore.install(package)):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/test-sha256-validated")):equals(true)
		expect(require("test-sha256-validated")):equals(1)
		expect(unicornCore.uninstall("test-sha256-validated")):equals(true)
	end)

	pending("unicorn.core.install causes problems when hashes are bad", function()
		local unicornCore = require("unicorn.core")

		local package = {}
		package.pkgType = "local.string"
		package.unicornSpec = "v1.0.0"
		package.name = "test-sha256-invalid"
		package.version = "0.0.1"
		package.instdat = {}
		package.instdat.filemaps = {}
		package.instdat.filemaps["return 1"] = "/lib/test-sha256-invalid.lua"
		package.security = {}
		package.security.sha256 = {}
		-- 8373...896c is hash of "return 2"
		package.security.sha256["/lib/test-sha256-invalid.lua"] =
			"8373f7e086bb27784827ef8f2f4ae118e05d58b67f513f82c2316dc57b0d896c"

		expect.error(testutils.doPackageProviderInstall(except, package))
	end)

	it("core.install replaces an older package with a newer one", function()
		local unicornCore = require("unicorn.core")

		local olderPackage = {}
		olderPackage.pkgType = "local.string"
		olderPackage.unicornSpec = "v1.0.0"
		olderPackage.name = "test-older-replaces-newer"
		olderPackage.version = "0.0.1"
		olderPackage.instdat = {}
		olderPackage.instdat.filemaps = {}
		olderPackage.instdat.filemaps["return 1"] = "/lib/test-older-replaces-newer.lua"

		local newerPackage = {}
		newerPackage.pkgType = "local.string"
		newerPackage.unicornSpec = "v1.0.0"
		newerPackage.name = "test-older-replaces-newer"
		newerPackage.version = "0.0.2"
		newerPackage.instdat = {}
		newerPackage.instdat.filemaps = {}
		newerPackage.instdat.filemaps["return 2"] = "/lib/test-older-replaces-newer.lua"

		expect(unicornCore.install(olderPackage)):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/" .. olderPackage.name)):equals(true)
		expect(require(olderPackage.name)):equals(1)
		expect(unicornCore.install(newerPackage)):equals(true)
		-- un-cache the previous output, since it changes
		package.loaded[newerPackage.name] = nil
		expect(require(newerPackage.name)):equals(2)
		expect(unicornCore.uninstall(newerPackage.name)):equals(true)
	end)

	it("core.install refuses to replace a newer package with an older one", function()
		local unicornCore = require("unicorn.core")

		local olderPackage = {}
		olderPackage.pkgType = "local.string"
		olderPackage.unicornSpec = "v1.0.0"
		olderPackage.name = "test-fail-newer-replaces-older"
		olderPackage.version = "0.0.1"
		olderPackage.instdat = {}
		olderPackage.instdat.filemaps = {}
		olderPackage.instdat.filemaps["return 1"] = "/lib/test-fail-newer-replaces-older.lua"

		local newerPackage = {}
		newerPackage.pkgType = "local.string"
		newerPackage.unicornSpec = "v1.0.0"
		newerPackage.name = "test-fail-newer-replaces-older"
		newerPackage.version = "0.0.2"
		newerPackage.instdat = {}
		newerPackage.instdat.filemaps = {}
		newerPackage.instdat.filemaps["return 2"] = "/lib/test-fail-newer-replaces-older.lua"

		expect(unicornCore.install(newerPackage)):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/" .. olderPackage.name)):equals(true)
		expect(require(olderPackage.name)):equals(2)
		expect.error(unicornCore.install, newerPackage)
		expect(unicornCore.uninstall(newerPackage.name)):equals(true)
	end)

	it("core.install refuses to replace a package with one of the same version", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "local.string"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "test-fail-same-replaces-same"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.instdat.filemaps = {}
		thisPackage.instdat.filemaps["return 1"] = "/lib/test-fail-same-replaces-same.lua"

		expect(unicornCore.install(thisPackage)):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/" .. thisPackage.name)):equals(true)
		expect(require(thisPackage.name)):equals(1)
		expect.error(unicornCore.install, thisPackage)
		expect(unicornCore.uninstall(thisPackage.name)):equals(true)
	end)

	it("core.install refuses to install a package that conflicts with another", function()
		local unicornCore = require("unicorn.core")

		local firstPackage = {}
		firstPackage.pkgType = "local.string"
		firstPackage.unicornSpec = "v1.0.0"
		firstPackage.name = "test-fail-conflicts-foo"
		firstPackage.version = "0.0.1"
		firstPackage.instdat = {}
		firstPackage.instdat.filemaps = {}
		firstPackage.instdat.filemaps["return 1"] = "/lib/test-fail-conflicts-foo.lua"
		firstPackage.rel = {}
		firstPackage.rel.conflicts = { "test-fail-conflicts-bar" }

		local secondPackage = {}
		secondPackage.pkgType = "local.string"
		secondPackage.unicornSpec = "v1.0.0"
		secondPackage.name = "test-fail-conflicts-bar"
		secondPackage.version = "0.0.1"
		secondPackage.instdat = {}
		secondPackage.instdat.filemaps = {}
		secondPackage.instdat.filemaps["return 1"] = "/lib/test-fail-conflicts-foo.lua"
		secondPackage.rel = {}
		secondPackage.rel.conflicts = { "test-fail-conflicts-foo" }

		expect(unicornCore.install(firstPackage)):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/" .. firstPackage.name)):equals(true)
		expect(require(firstPackage.name)):equals(1)
		expect.error(unicornCore.install, secondPackage)
		expect(unicornCore.uninstall(firstPackage.name)):equals(true)
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
