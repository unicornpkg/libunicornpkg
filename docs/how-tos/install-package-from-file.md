# How to install a package from a file

This guide will show you how to install a package without using a remote.

This guide assumes you have [installed unicornpkg](./installation.md) and [created a package](./create-a-package.md) (or downloaded one from the Internet).

:::{hint}
The `pastebin` and `wget` commands might be helpful in getting your package onto a computer.
:::

2. Install your package with `unicorntool install full/path/to/package.lua`.
3. Play with your package. The package most likely got installed to `/lib` or `/bin`; check one of those directories and play around with it!
4. Remove your package with `unicorntool uninstall package-name`. The package name is in the source package. If it's an application, there is a good chance it's name is the name of the package.
