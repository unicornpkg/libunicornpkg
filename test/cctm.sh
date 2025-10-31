#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$(git rev-parse --show-toplevel)"
echo "# Source dir is $SOURCE_DIR"
echo "# CraftOS-PC is $(which craftos)"

DATA_DIR="$(mktemp -d)"
echo "# Data dir is $DATA_DIR"
mkdir -p "$DATA_DIR"/{config,computer/0}
cp "$SOURCE_DIR"/test/global.json "$DATA_DIR"/config/global.json

rm -f "$SOURCE_DIR"/tap_results.txt
echo "TAP version 14" > "$SOURCE_DIR"/tap_results.txt

COMPUTER_DIR="$DATA_DIR/computer/0"
cp "$SOURCE_DIR"/test/settings "$COMPUTER_DIR"/.settings
mkdir -p "$COMPUTER_DIR"/{lib,bin,etc/unicorn/remotes,etc/unicorn/packages/installed}
cp -r "$SOURCE_DIR/unicorn" "$COMPUTER_DIR/lib"
cp "$SOURCE_DIR/vendor/semver/semver.lua" "$COMPUTER_DIR/lib"
cp "$SOURCE_DIR/vendor/sha256.lua" "$COMPUTER_DIR/lib"
cp "$SOURCE_DIR/vendor/mcfly.lua" "$COMPUTER_DIR/bin/mcfly.lua"

echo "https://unicornpkg.github.io/unicornpkg-main" > "$COMPUTER_DIR/etc/unicorn/remotes/90-main.txt"

cp -r "$SOURCE_DIR" "$COMPUTER_DIR/source"

function runTests() {
    extraArgs="$@"
    craftos --directory "$DATA_DIR" --headless --exec "_G.UNICORN_DEBUG_DO_NOT_USE_IN_PRODUCTION_CODE = 1; shell.run('bin/mcfly.lua source/test/unicorn/'); os.shutdown()" "$extraArgs"
}

runTests
# FIXME: start testing under Recrafted once everything works
# runTests --rom "$SOURCE_DIR/vendor/recrafted/data/computercraft/lua"

cat $COMPUTER_DIR/tap_results.txt >> "$SOURCE_DIR"/tap_results.txt
