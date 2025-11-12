package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

describe("provider.io.sc3.p", function()
	it("require('unicorn.provider.io.sc3.p') returns a function", function()
		expect(require("unicorn.provider.io.sc3.p")):type("table")
	end)
	it("can be installed and uninstalled", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "io.sc3.p"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "io-sc3-p-test"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.instdat.filemaps = {}
		thisPackage.instdat.filemaps["MvqH3FEeAx"] = "/lib/io-sc3-p-test.lua"

		expect(unicornCore.install(thisPackage)):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/" .. thisPackage.name)):equals(true)
		expect(require(thisPackage.name)):equals(1)
		expect(unicornCore.uninstall(thisPackage.name)):equals(true)
	end)
end)
