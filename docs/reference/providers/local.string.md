# `local.string`

`local.string` is the identifier for a special package provider that writes predetermined strings to a location on disk.

## `instdat.filemaps`

An input looks like this:

```lua
local package = {}
local package.pkgType = "local.string"
local package.unicornSpec = "v1.0.0"
local package.instdat
local package.instdat.filemaps = {}
local package.instdat.filemaps["Some string"] = "/some/path"
```

`instdat.filemaps` has any string (including multiline strings) as the first value (the key), and a valid file location as the second value (the value).
