# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [unreleased]

## v1.3.1
- The [](./providers/ht.sr.md) provider for [Sourcehut](https://sourcehut.org) has been added.
- The `semver` and `sha256` modules are now optional in cases where they would never be invoked.
     - The related code will raise an error if it tries to find the modules but cannot.
- The `rel.conflicts` field has been added.
  The field should be a list of package names.
  If any of the packages listed are installed when installing this package,
  the installation will fail.
- The `_HOST` variable can now be accessed from within the package evaluation sandbox.

## v1.3.0
- Packages are now evaluated inside of a sandbox, preventing package tables from having side effects.
  The functions available in the sandbox are defined in `unicorn.util.sandbox_env`.
  **This does not provide much security. Do not install untrusted packages!**
    - As a side effect, packages available on a remote can no longer be Lua bytecode (but this was never supported to begin with).
- The [](./providers/org.codeberg.md) provider for [Codeberg](https://codeberg.org) has been added.
- Packages with an empty `instdat` can now be uninstalled.
- Packages with `dirs` can now be uninstalled.
- When attempting an HTTP request with `unicorn.util.smartHttp`,
  the function will throw an error if we receive a bad response.
  As a result, operations that make HTTP requests will now fail if the server sends such a response.
  ([Reported](https://github.com/unicornpkg/libunicornpkg/issues/33) by [@Commandcracker](https://github.com/Commandcracker))
- When fetching a file from a package remote, the file is no longer written to `/tmp`. ([Reported](https://github.com/unicornpkg/libunicornpkg/issues/49) by [@Commandcracker](https://github.com/Commandcracker))
- Logging is slightly less verbose. Debug logging can be enabled by setting
  the `_G.UNICORN_DEBUG_DO_NOT_USE_IN_PRODUCTION_CODE` variable to `1`.
  **This interface is not stable.**
- Remotes defined in `/etc/unicorn/remotes` must now end with the `.txt` file extension.
- [Recrafted](https://ocaweso.me/recrafted/) is no longer officially supported.
  The initial support was very subpar, and went untested for so long
  that it broke entirely.
  **Recrafted support will come back in a future release.**
  (Tracked by [#12](https://github.com/unicornpkg/libunicornpkg/issues/12))

## v1.2.1

- Fix a bug where attempting to uninstall and then reinstall a package would result in an error. ([Reported](https://github.com/unicornpkg/wing/issues/19#issuecomment-3029323428) by [@rapidradiance](https://github.com/rapidradiance))

## v1.2.0

- Add `UnicornInstall` and `UnicornUninstall` events with `os.queueEvent`.
- Add the `instdat.gitlab_instance` field in the GitLab provider.
- Add the [](./providers/local.nothing.md) provider. This is useful for
  making packages that don't need to contain anything; for example,
  packages which function as "groups" to install certain packages
  at once, or packages for software that is already installed.
- Migrated the project to use `require` with a custom `package.path` value.
    - Retroactive note: **This breaks most installations of the CLI.**
      The breakages that this change caused in the CLI are fixed in CLI version 1.2.1 or later.

## v1.1.0

- Fix scripts provider.
- Add `dirs` module.
- Use external installation of `semver.lua` if present.

## v1.0.0

- Add [Recrafted](https://recrafted.madefor.cc) support.
- Add package remotes.
- Add package versioning.
- Remove provider `dev.devbin`. Devbin [was](http://web.archive.org/web/20241006141524/https://devbin.dev/) a paste bin that was operated free-of-charge.
- Add [](./providers/com.github.release.md) provider. ([@Commandcracker](https://github.com/Commandcracker))
- Add [](./providers/local.generic.md) provider. ([@Commandcracker](https://github.com/Commandcracker))
- Add [](./providers/local.string.md) provider. ([@Commandcracker](https://github.com/Commandcracker))
- Add [scripts](https://unicornpkg.madefor.cc/specification/package-tables.html#script).
- Fix [](./providers/org.bitbucket.md) and [](./providers/com.gitlab.md) providers.

## v0.1.0

- Initial release.
