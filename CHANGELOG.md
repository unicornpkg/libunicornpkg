# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [unreleased]
- Packages are now evaluated inside of a sandbox, preventing package tables from having side effects.
  The functions available in the sandbox are defined in `unicorn.util.sandbox_env`.
  **This does not provide much security. Do not install untrusted packages!**
    - As a side effect, packages available on a remote can no longer be Lua bytecode (but this was never supported to begin with).
- Packages with an empty `instdat` can now be uninstalled.
- Packages with `dirs` can now be uninstalled.
- When fetching a file from a package remote, the file is no longer written to `/tmp`. ([Reported](https://github.com/unicornpkg/libunicornpkg/issues/49) by [@Commandcracker](https://github.com/Commandcracker))
- Logging is slightly less verbose. Debug logging can be enabled by setting
  the `_G.UNICORN_DEBUG_DO_NOT_USE_IN_PRODUCTION_CODE` variable to `1`.
  **This interface is not stable.**

## v1.2.1

- Fix a bug where attempting to uninstall and then reinstall a package would result in an error. ([Reported](https://github.com/unicornpkg/wing/issues/19#issuecomment-3029323428) by [@rapidradiance](https://github.com/rapidradiance))

## v1.2.0

- Add `UnicornInstall` and `UnicornUninstall` events with `os.queueEvent`.
- Add the `instdat.gitlab_instance` field in the GitLab provider.
- Add the `unicorn.provider.local.nothing` provider. This is useful for
  making packages that don't need to contain anything; for example,
  packages which function as "groups" to install certain packages
  at once, or packages for software that is already installed.

## v1.1.0

- Fix scripts provider.
- Add `dirs` module.
- Use external installation of `semver.lua` if present.

## v1.0.0

- Add [Recrafted](https://recrafted.madefor.cc) support.
- Add package remotes.
- Add package versioning.
- Remove provider [`dev.devbin`](https://unicornpkg.madefor.cc/api-reference/unicorn.core.providers/dev.devbin.html).
- Add `com.github.releases` provider. ([@Commandcracker](https://github.com/Commandcracker))
- Add `local.generic` provider. ([@Commandcracker](https://github.com/Commandcracker))
- Add `local.string` provider. ([@Commandcracker](https://github.com/Commandcracker))
- Add [scripts](https://unicornpkg.madefor.cc/specification/package-tables.html#script).
- Fix `org.bitbucket` and `com.gitlab` providers.

## v0.1.0

- Initial release.
