fs.makeDir("/lib/unicorn")

local package = {}
package.name = "unicornpkg-provider-local.string"
package.instdat = {}
package.instdat.repo_owner = "unicornpkg"
package.instdat.repo_name = "unicornpkg"
package.instdat.repo_ref = "v0.1.0"
package.instdat.filemaps = {}
package.instdat.filemaps["unicorn/provider/local.string.lua"] = "/lib/unicorn/provider/local.string.lua"
package.rel = {}
package.rel.depends = {
	"unicornpkg",
}
package.pkgType = "com.github"
package.unicornSpec = "v1.0.0"
package.version = "1.0.0"

return package
