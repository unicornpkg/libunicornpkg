#!/usr/bin/env just --justfile

default: lint

lint:
	-selene $(git ls-files | grep '\.lua' | grep -v "semver\.lua")

autofix:
	stylua .

docs:
	illuaminate doc-gen

sync:
	git pull --rebase; git push
