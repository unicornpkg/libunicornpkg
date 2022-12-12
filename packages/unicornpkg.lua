fs.makeDir("/lib/unicorn")

local package = {}
package.name = "unicornpkg"
package.instdat = {}
package.instdat.repo_owner = "unicornpkg"
package.instdat.repo_name = "unicornpkg"
package.instdat.repo_ref = "v1.0.0"
package.instdat.filemaps = {}
package.instdat.filemaps["unicorn/init.lua"] = "/lib/unicorn/init.lua"
package.instdat.filemaps["unicorn/core.lua"] = "/lib/unicorn/core.lua"
package.instdat.filemaps["unicorn/util.lua"] = "/lib/unicorn/util.lua"
package.pkgType = "com.github"
package.unicornSpec = "v1.0.0"
package.version = "1.0.0"

return package
