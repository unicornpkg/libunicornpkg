package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

local testutils = require("testutils")

describe("provider.org.archive", function()
	testutils.checkPackageProviderIsWellFormed(it, "org.archive")
	it("can be installed and uninstalled", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "org.archive"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "org-archive-test"
		thisPackage.version = "0.0.1"
		-- Since I don't want to add a junk file to IA, let's use a copy of the GPL
		thisPackage.instdat = {}
		thisPackage.instdat.item_name = "GPL-3.0"
		thisPackage.instdat.filemaps = {}
		thisPackage.instdat.filemaps["gpl-3.0.txt"] = "/tmp/gpl-3.0.txt"

		expect(unicornCore.install(thisPackage)):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/" .. thisPackage.name)):equals(true)
		local f = fs.open("/tmp/gpl-3.0.txt", "r")
		local firstLine = f.readLine()
		f.close()
		expect(firstLine == "                    GNU GENERAL PUBLIC LICENSE"):equals(true)
		expect(unicornCore.uninstall(thisPackage.name)):equals(true)
	end)
end)
