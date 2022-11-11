local unicorn = {}
unicorn.core = dofile("/lib/unicorn/core.lua")
unicorn.util = dofile("/lib/unicorn/util.lua")
unicorn.remote = dofile("/lib/unicorn/remote.lua")
unicorn.semver = dofile("/lib/unicorn/semver.lua")

return unicorn
