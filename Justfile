#!/usr/bin/env just --justfile

default: lint

install:
	npm install --save-dev --silent

lint: install
	npx eslint .
