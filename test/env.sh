#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$(git rev-parse --show-toplevel)"

function buildDataDir() {
    DATA_DIR="$(mktemp -d)"
    echo "# Data dir is $DATA_DIR" >&2
    mkdir -p "$DATA_DIR"/{config,computer/0}
    cp "$SOURCE_DIR"/test/global.json "$DATA_DIR"/config/global.json

    COMPUTER_DIR="$DATA_DIR/computer/0"
    cp "$SOURCE_DIR"/test/settings "$COMPUTER_DIR"/.settings
    mkdir -p "$COMPUTER_DIR"/{startup,lib,bin,etc/unicorn/remotes,etc/unicorn/packages/installed}
    cp "$SOURCE_DIR"/cli/{hoof,unicorntool}.lua "$COMPUTER_DIR"/bin
    cp "$SOURCE_DIR"/cli/{hoof,unicorntool}-completion.lua "$COMPUTER_DIR"/startup/
    cp "$SOURCE_DIR"/extras/unix-path-bootstrap/unix-path-bootstrap.lua "$COMPUTER_DIR"/startup/20-unix-path-bootstrap.lua

    echo "https://unicornpkg.github.io/unicornpkg-main" > "$COMPUTER_DIR/etc/unicorn/remotes/90-main.txt"
    # add a symlink to ./env, for inspecting the environment
    rm -f "$SOURCE_DIR/test/env"
    ln -s "$DATA_DIR" "$SOURCE_DIR/test/env"

    echo "$DATA_DIR"
}

function runCraftos() {
    echo "# CraftOS-PC is $(which craftos)" >&2
    craftos \
        --mount-ro "source=$SOURCE_DIR" \
        --mount-ro "lib/unicorn=$SOURCE_DIR/unicorn" \
        "$@"
}

function runTests() {
    DATA_DIR="$(buildDataDir)"
    cp "$SOURCE_DIR/test/startup.lua" "$DATA_DIR/computer/0/startup.lua"
    runCraftos \
        --headless \
        --directory "$DATA_DIR"
}

function runDevenv() {
    DATA_DIR="$(buildDataDir)"
    runCraftos \
        --cli \
        --directory "$DATA_DIR"
}
