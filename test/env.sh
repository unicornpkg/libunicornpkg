#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$(git rev-parse --show-toplevel)"
echo "# Source dir is $SOURCE_DIR" >&2
echo "# CraftOS-PC is $(which craftos)" >&2

function buildDataDir() {
    DATA_DIR="$(mktemp -d)"
    echo "# Data dir is $DATA_DIR" >&2
    mkdir -p "$DATA_DIR"/{config,computer/0}
    cp "$SOURCE_DIR"/test/global.json "$DATA_DIR"/config/global.json

    COMPUTER_DIR="$DATA_DIR/computer/0"
    cp "$SOURCE_DIR"/test/settings "$COMPUTER_DIR"/.settings
    mkdir -p "$COMPUTER_DIR"/{lib,bin,etc/unicorn/remotes,etc/unicorn/packages/installed}
    cp "$SOURCE_DIR"/cli/{hoof,unicorntool}.lua "$COMPUTER_DIR"/bin

    echo "https://unicornpkg.github.io/unicornpkg-main" > "$COMPUTER_DIR/etc/unicorn/remotes/90-main.txt"
    echo "$DATA_DIR"
}

function runCraftos() {
    craftos \
        --mount-ro "source=$SOURCE_DIR" \
        --mount-ro "lib/unicorn=$SOURCE_DIR/unicorn" \
        "$@"
}

function runTests() {
    DATA_DIR="$(buildDataDir)"
    # add a symlink to ./testenv, for inspecting the environment
    rm -f "$SOURCE_DIR/test/testenv"
    ln -s "$DATA_DIR" "$SOURCE_DIR/test/testenv"
    cp "$SOURCE_DIR/test/startup.lua" "$DATA_DIR/computer/0/startup.lua"
    runCraftos \
        --headless \
        --directory "$DATA_DIR"
}
