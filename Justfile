#!/usr/bin/env just --justfile

set export

default: lint

lint:
	selene . --config .selene.toml

test:
  ./test/cctm.sh

autofix:
	stylua .
