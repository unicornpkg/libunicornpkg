#!/usr/bin/env just --justfile

default: lint

lint:
	illuaminate lint

autofix:
	illuaminate fix

docs:
	illuaminate doc-gen

sync:
	git pull --rebase; git push
