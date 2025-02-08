#!/usr/bin/env just --justfile

set export

COMPUTER_ID := "1970301799" # 'upkg' in octal

default: lint

lint:
	-ln -sr .github/selene/selene-cc-tweaked/cc-tweaked.yaml .github/selene/cc-tweaked.yaml
	-selene $(git ls-files | grep '\.lua' | grep -v "semver\.lua") --config ".github/selene/selene.toml"

test:
  ./test/cctm.sh

autofix:
	stylua .

docs:
	illuaminate doc-gen

sync:
	git pull --rebase; git push

# install lib and vendored dependencies to CraftOS-PC computer #1970301799
craftos-install:
  #!/usr/bin/env sh
  if [ $(uname) = "Darwin" ]; then
    datadir="$HOME/Library/Application Support/CraftOS-PC"
  else
    datadir="$HOME/.craftos-pc"
  fi

  computerdir="$datadir/computer/$COMPUTER_ID"

  mkdir -p "$computerdir/lib"

  [ -L "$computerdir/lib/unicorn" ] && rm "$computerdir/lib/unicorn"
  [ -L "$computerdir/lib/libcompat.lua" ] && rm "$computerdir/lib/libcompat.lua"
  [ -L "$computerdir/lib/semver.lua" ] && rm "$computerdir/lib/semver.lua"
  ln -s "$(pwd)/unicorn" "$computerdir/lib/unicorn"
  ln -s "$(pwd)/vendor/libcompat/libcompat.lua" "$computerdir/lib/libcompat.lua"
  ln -s "$(pwd)/vendor/semver/semver.lua" "$computerdir/lib/semver.lua"

# run computer #1970301799 in CraftOS-PC
craftos-run:
  #!/usr/bin/env sh
  
  craftos --id $COMPUTER_ID

