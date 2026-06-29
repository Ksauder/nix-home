#!/bin/sh

BRANCH="main"

if ! command -v nix >/dev/null 2>&1; then
    curl -fsSL https://raw.githubusercontent.com/ksauder/nix-home/refs/heads/${BRANCH}/install_nix.sh | bash
fi

arch="$(uname -m)"
os="$(uname -s | tr '[:upper:]' '[:lower:]')"

nix run home-manager/master -- switch --flake github:ksauder/nix-home/${BRANCH}#kyle@${arch}-${os}
