describe("unicorntool", function()
	pending("can install a package table", function()
		expect(os.run({}, "/bin/unicorntool", "install", "source/test/data/unicorntool-install-test-package.lua")):equals(
			true
		)

		expect(fs.exists("/etc/unicorn/packages/installed/unicorntool-install-test")):equals(true)
		expect(require("unicorntool-install-test-package")):equals(1)
	end)
	pending("can uninstall a package", function()
		expect(os.run({}, "/bin/unicorntool", "uninstall", "unicorntool-install-test")):equals(true)
		expect(fs.exists("/etc/unicorn/packages/installed/unicorntool-install-test")):equals(false)
		expect.error(require, "unicorntool-install-test")
	end)
end)
