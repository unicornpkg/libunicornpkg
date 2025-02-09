#!/usr/bin/env just --justfile

set export

default: lint test

lint:
	selene . --config .selene.toml

test:
  ./test/cctm.sh
  tappy tap_results.txt

autofix:
	stylua .
