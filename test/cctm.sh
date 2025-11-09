#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$(git rev-parse --show-toplevel)"
echo "# Source dir is $SOURCE_DIR"
echo "# CraftOS-PC is $(which craftos)"

DATA_DIR="$(mktemp -d)"
echo "# Data dir is $DATA_DIR"
mkdir -p "$DATA_DIR"/{config,computer/0}
cp "$SOURCE_DIR"/test/global.json "$DATA_DIR"/config/global.json

# add a symlink to ./testenv, for inspecting the environment
rm -f "$SOURCE_DIR/test/testenv"
ln -s "$DATA_DIR" "$SOURCE_DIR/test/testenv"

rm -f "$SOURCE_DIR"/tap_results.txt
echo "TAP version 14" > "$SOURCE_DIR"/tap_results.txt

COMPUTER_DIR="$DATA_DIR/computer/0"
cp "$SOURCE_DIR"/test/settings "$COMPUTER_DIR"/.settings
mkdir -p "$COMPUTER_DIR"/{lib,bin,etc/unicorn/remotes,etc/unicorn/packages/installed}
cp "$SOURCE_DIR/test/startup.lua" "$COMPUTER_DIR/startup.lua"
cp "$SOURCE_DIR/vendor/mcfly.lua" "$COMPUTER_DIR/bin/mcfly.lua"

echo "https://unicornpkg.github.io/unicornpkg-main" > "$COMPUTER_DIR/etc/unicorn/remotes/90-main.txt"

function runTests() {
    extraArgs="$@"
    craftos \
        --directory "$DATA_DIR" \
        --headless \
        --mount-ro "source=$SOURCE_DIR" \
        --mount-ro "lib/unicorn=$SOURCE_DIR/unicorn" \
        "$extraArgs"
}

runTests
# FIXME: start testing under Recrafted once everything works
# runTests --rom "$SOURCE_DIR/vendor/recrafted/data/computercraft/lua"

cat $COMPUTER_DIR/tap_results.txt >> "$SOURCE_DIR"/tap_results.txt
