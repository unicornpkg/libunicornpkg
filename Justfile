#!/usr/bin/env just --justfile

default: lint

lint:
	-ln -sr .github/selene/selene-cc-tweaked/cc-tweaked.yaml .github/selene/cc-tweaked.yaml
	-selene $(git ls-files | grep '\.lua' | grep -v "semver\.lua") --config ".github/selene/selene.toml"

autofix:
	stylua .

docs:
	illuaminate doc-gen

sync:
	git pull --rebase; git push
