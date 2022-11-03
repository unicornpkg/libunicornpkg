fs.makeDir("/lib/unicorn")

local package = {}
package.name = "unicornpkg-provider-dev.devbin"
package.instdat = {}
package.instdat.repo_owner = "unicornpkg"
package.instdat.repo_name = "unicornpkg"
package.instdat.repo_ref = "v0.1.0"
package.instdat.filemaps = {}
package.instdat.filemaps["unicorn/provider/dev.devbin.lua"] = "/lib/unicorn/provider/dev.devbin.lua"
package.rel.depends = {
	"unicornpkg"
}
package.pkgType = "com.github"
package.unicornSpec = "v1.0.0"
package.version = "0.1.0"

return package