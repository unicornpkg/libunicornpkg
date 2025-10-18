# TypeScript to Lua transpiler types for libunicornpkg

Provides hooks into TypeScript's typing system for use with the [TypeScript to Lua transpiler](https://typescripttolua.github.io).

## Usage

### Via jsr.io

This package is [available as the `@unicornpkg/types-libunicornpkg` package](https://jsr.io/@unicornpkg/types-libunicornpkg) on [jsr.io](https://jsr.io). See [jsr.io's documentation for information on how to install this package](https://jsr.io/docs/using-packages).


After it's been installed, you can import it like this:

```ts
import { unicorn } from "@unicornpkg/types-libunicornpkg";
```

### As a submodule (legacy)

Add this as a submodule with the path `types/unicorn`:

```
git submodule add https://github.com/unicornpkg/tstl-types-libunicornpkg types/unicorn
git submodule update --init --recurse
```

Then, `import` the library:

```ts
import { unicorn } from "./types/unicorn/unicorn.d.ts";
```

## Development

Contributions are always welcome! This section demonstrates how to contribute to this project.

1. Install [just](https://github.com/casey/just). Just is a tool that will make your life significantly easier if you've never developed on TypeScript before.
2. Fork the repository and clone it locally.
3. Execute `just install`. This installs developer dependencies.
4. Occasionally execute `just lint`. This uses `eslint` to check for errors.
5. Commit your changes, push them up to GitHub, and open a PR.
