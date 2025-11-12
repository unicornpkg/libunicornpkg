package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

describe("provider.org.codeberg", function()
	it("require('unicorn.provider.org.codeberg') returns a function", function()
		expect(require("unicorn.provider.org.codeberg")):type("table")
	end)
	it("can be installed and uninstalled", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "org.codeberg"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "org-codeberg-test"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.instdat.repo_owner = "tomodachi94"
		thisPackage.instdat.repo_name = "unicornpkg-test-repo"
		thisPackage.instdat.repo_ref = "ee7a8440d3632544c4bf0ef7a1ac566922bce436"
		thisPackage.instdat.filemaps = {}
		thisPackage.instdat.filemaps["org-codeberg-test.lua"] = "/lib/org-codeberg-test.lua"

		expect(unicornCore.install(thisPackage)):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/" .. thisPackage.name)):equals(true)
		expect(require(thisPackage.name)):equals(1)
		expect(unicornCore.uninstall(thisPackage.name)):equals(true)
	end)
end)
