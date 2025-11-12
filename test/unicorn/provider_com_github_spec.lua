package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

describe("provider.com.github", function()
	it("require('unicorn.provider.com.github') returns a function", function()
		expect(require("unicorn.provider.com.github")):type("table")
	end)
	it("can be installed and uninstalled", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "com.github"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "com-github-test"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.instdat.repo_owner = "unicornpkg"
		thisPackage.instdat.repo_name = "test-repo"
		thisPackage.instdat.repo_ref = "caaea67460e1c3b8e275d83500bb1100c3a1837c"
		thisPackage.instdat.filemaps = {}
		thisPackage.instdat.filemaps["com-github-test.lua"] = "/lib/com-github-test.lua"

		expect(unicornCore.install(thisPackage)):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/" .. thisPackage.name)):equals(true)
		expect(require(thisPackage.name)):equals(1)
		expect(unicornCore.uninstall(thisPackage.name)):equals(true)
	end)
end)
