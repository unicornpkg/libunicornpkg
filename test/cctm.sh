#!/usr/bin/env bash
set -euo pipefail

SOURCE_DIR="$(git rev-parse --show-toplevel)"
echo "# Source dir is $SOURCE_DIR"
echo "# CraftOS-PC is $(which craftos)"

DATA_DIR="$(mktemp -d)"
echo "# Data dir is $DATA_DIR"
mkdir -p "$DATA_DIR"/{config,computer/0}
cp "$SOURCE_DIR"/test/global.json "$DATA_DIR"/config/global.json

COMPUTER_DIR="$DATA_DIR/computer/0"
mkdir -p "$COMPUTER_DIR"/{lib,bin}
cp -r "$SOURCE_DIR/unicorn" "$COMPUTER_DIR/lib"
cp "$SOURCE_DIR/vendor/semver/semver.lua" "$COMPUTER_DIR/lib"
cp "$SOURCE_DIR/vendor/sha256.lua" "$COMPUTER_DIR/lib"
cp "$SOURCE_DIR/vendor/mcfly.lua" "$COMPUTER_DIR/bin/mcfly.lua"

cp -r "$SOURCE_DIR" "$COMPUTER_DIR/source"

craftos --directory "$DATA_DIR" --headless --exec "shell.run('bin/mcfly.lua source/test/unicorn/'); os.shutdown()"
