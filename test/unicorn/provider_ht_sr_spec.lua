package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

describe("provider.ht.sr", function()
	it("require('unicorn.provider.ht.sr') returns a function", function()
		expect(require("unicorn.provider.ht.sr")):type("function")
	end)
	it("can be installed and uninstalled", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "ht.sr"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "ht-sr-test"
		thisPackage.version = "0.0.1"
        -- Since I don't want to pay for a Sourcehut account, let's use this repository I found
		thisPackage.instdat = {}
		thisPackage.instdat.repo_owner = "~ntietz"
		thisPackage.instdat.repo_name = "gal.gay"
		thisPackage.instdat.repo_ref = "b2d67e4b1008991d8340f8e563f4f1a198f42939"
		thisPackage.instdat.filemaps = {}
		thisPackage.instdat.filemaps["GAL_text.txt"] = "/tmp/gal.txt"

		expect(unicornCore.install(thisPackage)):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/" .. thisPackage.name)):equals(true)
		local f = fs.open("/tmp/gal.txt", "r")
		local firstLine = f.readLine()
		f.close()
		expect(firstLine == "# Gay Agenda License - 1.0"):equals(true)
		expect(unicornCore.uninstall(thisPackage.name)):equals(true)
	end)
end)
