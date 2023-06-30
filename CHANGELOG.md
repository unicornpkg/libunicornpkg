# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [unreleased]

- Add `UnicornInstall` and `UnicornUninstall` events with `os.queueEvent`.
- Add the `instdat.gitlab_instance` field in the GitLab provider.
- Add build hooks, which are reusable scripts that can be used in `postinstall` scripts:
    - `makeBinWrapper`, a faux symlink creator for binaries (executable Lua files).
    - `makeModuleWrapper`, a faux symlink creator for Lua modules.
    - `patchPackageDotPath`, a default build hook which patches `package.path`, allowing for modules to be sourced from `/lib`.

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
