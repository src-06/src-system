#!/usr/bin/env bash

set -e

FLAKE_LOCK="$HOME/.src-system/flake.lock"

if [ -f "$FLAKE_LOCK" ]; then
  read -r owner repo rev < <(
    jq -r '.nodes["nixpkgs-unstable"].locked | "\(.owner) \(.repo) \(.rev)"' "$FLAKE_LOCK"
  )

  nix flake lock --override-input nixpkgs "github:$owner/$repo/$rev"
fi
