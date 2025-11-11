# Contribution guidelines

Thank you for considering making a contribution to libunicornpkg!

## Development tooling

We recommend using [Nix](https://nixos.org/) for installing developer tooling.

Use `nix develop` to retrieve all of our development dependencies, or use [Direnv](https://direnv.net/) with [`nix-direnv`](https://github.com/nix-community/nix-direnv).

We use the [`just` command runner](https://just.systems). Instead of adding things to GitHub Actions, we prefer adding recipes to our `Justfile` that are then executed in GitHub Actions.

You can enter a preconfigured CraftOS-PC emulator by running `just develop`.

## Code formatting

We use a variety of code formatters to avoid wasting time on discussions about code formatting.

These formatters should be invoked using [`treefmt`](https://treefmt.com), or using `just autofix`.

## Linting

We use a handful of linters to avoid common pitfalls in our code. Run them using `just lint`.

## Documentation

We use [Sphinx](https://sphinx-doc.org) combined with [`sphinx-lua-ls`](https://sphinx-lua-ls.readthedocs.io/en/stable/) for documentation. The documentation can be built using `just docs`, and previewed using `just docs-preview`.

## Unit tests

We use McFly for unit tests. Documentation for McFly is sparse, but the source code can be found [here](https://github.com/cc-tweaked/CC-Tweaked/blob/mc-1.20.x/projects/core/src/test/resources/test-rom/mcfly.lua). Unit tests can be run in the CraftOS-PC emulator by running `just test`.

Please add unit tests when adding a new feature. Many examples can be found in `test/unicorn`.
