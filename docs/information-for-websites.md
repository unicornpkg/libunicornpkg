# Information for websites

libunicornpkg is capable of making requests to any defined [provider](./providers/index.rst), as well as to any URL through [](./providers/local.generic.md).

libunicornpkg always identifies itself through a [`User-Agent`](https://developer.mozilla.org/en-US/docs/Web/HTTP/Reference/Headers/User-Agent) header of the form `libunicornpkg {version} {link to this page}`.

If you would like the provider to be removed for a specific website that you maintain or are authorized to act on behalf of, please [file an issue](https://github.com/unicornpkg/libunicornpkg/issues) and it will be removed. However, **we will not ban specific hosts in `local.generic`,** because such restrictions can be easily bypassed.
