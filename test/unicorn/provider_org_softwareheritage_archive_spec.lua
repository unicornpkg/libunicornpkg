package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

describe("provider.org.softwareheritage.archive", function()
	it("require('provider.org.softwareheritage.archive') returns a function", function()
		expect(require("unicorn.provider.org.softwareheritage.archive")):type("function")
	end)
	it("can be installed and uninstalled", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "org.softwareheritage.archive"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "org-softwareheritage-archive-test"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.instdat.filemaps = {}
		local long_swhid = [[swh:1:cnt:a5b86d1b8bda4040da84c67cbb4ae127d6141a4c]]
		thisPackage.instdat.filemaps[long_swhid] = "/lib/org-softwareheritage-archive-test.lua"

		expect(unicornCore.install(thisPackage)):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/" .. thisPackage.name)):equals(true)
		expect(require(thisPackage.name)):equals(1)
		expect(unicornCore.uninstall(thisPackage.name)):equals(true)
	end)
end)
