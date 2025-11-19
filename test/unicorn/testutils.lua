local testutils = {}

---@param except function
---@param thisPackage table
function testutils.doPackageProviderInstall(except, thisPackage)
	local unicornCore = require("unicorn.core")

	expect(unicornCore.install(thisPackage)):equals(true)
	expect(fs.exists("/etc/unicorn/packages/installed/" .. thisPackage.name)):equals(true)
	expect(require(thisPackage.name)):equals(1)
	expect(unicornCore.uninstall(thisPackage.name)):equals(true)
end

function testutils.checkPackageProviderIsWellFormed(it, providerName)
	local message = string.format([[require("unicorn.provider.%s) returns a function]], providerName)
	it(message, function()
		expect(require("unicorn.provider." .. providerName)):type("function")
	end)
end

return testutils
