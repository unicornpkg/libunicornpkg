#!/usr/bin/env just --justfile

set export := true

default: lint test

lint:
    #!/usr/bin/env bash
    treefmt --ci
    selene . --pattern "unicorn/*.lua" --pattern "cli/*.lua" --pattern "test/*.lua" --pattern "extras/*.lua"
    shellcheck */**.sh
    sphinx-lint docs \
        -i docs/.venv \
        -i docs/api # generated code
    cd ts-types && just lint

test:
    #!/usr/bin/env bash
    . ./installer/env.sh
    runTests

installer:
    #!/usr/bin/env bash
    . ./installer/env.sh
    buildInstaller

develop:
    #!/usr/bin/env bash
    set -euo pipefail
    . ./installer/env.sh
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

CURRENT_RELEASE := `git describe --tags --match "v*" --abbrev=0 | sed 's/v//g'`
TODAY := `TZ='America/Los_Angeles' date -I`

release new_version:
    # git status --porcelain || echo "Current tree is dirty, please commit your changes!" && exit 1
    # git rev-parse --abbrev-ref HEAD | grep -F "^main$" || echo "You're on the wrong branch!" && exit 1

    sed -i 's/{{ CURRENT_RELEASE }}/{{ new_version }}/g' unicorn/constants.lua
    sed -i 's/{{ CURRENT_RELEASE }}/{{ new_version }}/g' installer/pack.mcmeta
    # Append a new line after '## [unreleased]', another newline, and then a line like '## v1.0.0 - YYYY-MM-DD',
    # so that there is a "new" `## [unreleased]` section at the top.
    sed -i -e '/## \[unreleased\]/a\' -e '\' -e '## v{{ new_version }} - {{ TODAY }}' CHANGELOG.md

    git add CHANGELOG.md unicorn/constants.lua
    -git commit --edit -m "chore: release v{{ new_version }}" && git tag "v{{ new_version }}"

    echo "Now, run just release-publish if everything is okay!"

release-publish new_version: installer
    git push
    git push --tag
    gh release create "v{{ new_version }}" installer/install.lua.sfx installer/install.lua installer/datapack.zip --title "v{{ new_version }}" --notes-file ./.changelog-blurb.md
