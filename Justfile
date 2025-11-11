#!/usr/bin/env just --justfile

set export := true

default: lint test

lint:
    #!/usr/bin/env bash
    treefmt --ci
    selene . --pattern "unicorn/*.lua" --pattern "cli/*.lua" --pattern "test/*.lua" --pattern "extras/*.lua"
    shellcheck */**.sh
    cd ts-types && just lint

test:
    #!/usr/bin/env bash
    . ./test/env.sh
    runTests

develop:
    #!/usr/bin/env bash
    set -euo pipefail
    . ./test/env.sh
    runDevenv

docs *SPHINXOPTS:
    uv run --project docs -- \
    	sphinx-build -b html {{ SPHINXOPTS }} docs docs/_build

docs-preview: docs
    python3 -m http.server -d docs/_build

autofix:
    treefmt

_autofix-shellcheck *FILES:
    #!/usr/bin/env bash
    set -euxo pipefail
    shellcheck --format diff {{ FILES }} | patch -p1 || true
