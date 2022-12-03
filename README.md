# TypeScript to Lua transpiler types for libunicornpkg

Provides hooks into TypeScript's typing system for use with the [TypeScript to Lua transpiler](https://typescripttolua.github.io).

## Usage

Add this as a submodule with the path `types/unicorn`:

```
git submodule add https://github.com/unicornpkg/tstl-libunicorn-types ./types/unicorn
git submodule update --init --recurse
```

Then, `import` the library as usual.
