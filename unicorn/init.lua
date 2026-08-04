package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path

--- Using
--- -----
---
--- libunicornpkg should be loaded using ``require``.
--- If you are not familiar with ``require``, see `a guide on tweaked.cc <https://tweaked.cc/guide/using_require.html>`_ for more information.
--- libunicornpkg should have been installed to the ``/lib`` directory,
--- so a standard ``require`` doesn't usually work here.
--- You'll need to modify ``package.path`` so that ``require`` knows where to look for libunicornpkg:
---
--- >>> package.path = "/lib/?.lua;/lib/?;/lib/?/init.lua;" .. package.path
---
--- !doctype module
--- @class unicorn
local unicorn = {}
-- keep-sorted start
unicorn.constants = require("unicorn.constants")
unicorn.core = require("unicorn.core")
unicorn.remote = require("unicorn.remote")
unicorn.util = require("unicorn.util")
-- keep-sorted end

return unicorn
