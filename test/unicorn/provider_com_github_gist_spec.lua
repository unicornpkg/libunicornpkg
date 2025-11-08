package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

describe("provider.com.github.gist", function()
	it("require('unicorn.provider.com.github.gist') returns a function", function()
		expect(require("unicorn.provider.com.github.gist")):type("function")
	end)
	-- FIXME: make this work
	pending("can be installed and uninstalled", function()
		local unicornCore = require("unicorn.core")

		local thisPackage = {}
		thisPackage.pkgType = "com.pastebin"
		thisPackage.unicornSpec = "v1.0.0"
		thisPackage.name = "com-github-gist-test"
		thisPackage.version = "0.0.1"
		thisPackage.instdat = {}
        thisPackage.instdat.repo_owner = "tomodachi94"
        thisPackage.instdat.repo_name = "6b121766ef4ec1e5c97e6834879d90c3"
        thisPackage.instdat.repo_ref = "53d888d96535239201305f9c664560bce30d447b"
		thisPackage.instdat.filemaps = {}
		thisPackage.instdat.filemaps["com-github-gist-test.lua"] = "/lib/com-github-gist-test.lua"

		expect(unicornCore.install(thisPackage)):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/" .. thisPackage.name)):equals(true)
		expect(require(thisPackage.name)):equals(1)
		expect(unicornCore.uninstall(thisPackage.name)):equals(true)
	end)
end)
