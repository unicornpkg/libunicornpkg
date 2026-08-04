# How to install a package from a file

This guide will cover installing a package without using a remote.

This guide assumes you have a working install of libunicornpkg and unicorntool, which [the installer](installation.md) provides.

1. If your package isn't already available, download it using a tool like `wget`.
2. Install your package with `unicorntool install full/path/to/package.lua`.
3. Play with your package. The package most likely got installed to `/lib` or `/bin`; check one of those directories and play around with it!
4. Remove your package with `unicorntool uninstall package-name`. The package name is in the source package. If it's an application, there is a good chance it's name is the name of the package.
