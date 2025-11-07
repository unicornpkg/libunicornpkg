#!/usr/bin/env just --justfile

set export := true

default: lint test

lint:
    #!/usr/bin/env bash
    treefmt --ci
    selene . --pattern "unicorn/*.lua" --pattern "cli/*.lua" --pattern "test/*.lua"
    cd ts-types && just lint

test:
    ./test/cctm.sh
    tappy tap_results.txt

docs *SPHINXOPTS:
    uv run --project docs -- \
    	sphinx-build -b html {{ SPHINXOPTS }} docs docs/_build

autofix:
    treefmt
