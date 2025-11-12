package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

describe("provider.com.pastebin", function()
	it("require('unicorn.provider.com.pastebin') returns a function", function()
		expect(require("unicorn.provider.com.pastebin")):type("function")
	end)
	it("can be installed and uninstalled", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "com.pastebin"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "com-pastebin-test"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.instdat.filemaps = {}
		thisPackage.instdat.filemaps["21Qmqwa8"] = "/lib/com-pastebin-test.lua"

		expect(unicornCore.install(thisPackage)):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/" .. thisPackage.name)):equals(true)
		expect(require(thisPackage.name)):equals(1)
		expect(unicornCore.uninstall(thisPackage.name)):equals(true)
	end)
end)
