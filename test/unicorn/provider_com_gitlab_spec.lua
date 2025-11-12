package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

describe("provider.com.gitlab", function()
	it("require('unicorn.provider.com.gitlab') returns a function", function()
		expect(require("unicorn.provider.com.gitlab")):type("function")
	end)
	it("can be installed and uninstalled on the default instance", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "com.gitlab"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "com-gitlab-test"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
		thisPackage.instdat.repo_owner = "unicornpkg"
		thisPackage.instdat.repo_name = "test-repo"
		thisPackage.instdat.repo_ref = "eb68921911fafef3d66c2214e5fbf9bad540cb25854aadc5b008abc2170329ae"
		thisPackage.instdat.filemaps = {}
		thisPackage.instdat.filemaps["com-gitlab-test.lua"] = "/lib/com-gitlab-test.lua"

		expect(unicornCore.install(thisPackage)):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/" .. thisPackage.name)):equals(true)
		expect(require(thisPackage.name)):equals(1)
		expect(unicornCore.uninstall(thisPackage.name)):equals(true)
	end)
end)
