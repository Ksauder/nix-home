#!/bin/sh
# pull the repo down and switch with HM
set -e

if ! command -v git >/dev/null 2>&1; then
    echo "Requires git installed"
    exit 1
fi

if [ ! -d ~/.nixhome ]; then
    git clone git@github.com:Ksauder/nix-home.git ~/.nixhome
fi

BRANCH="${BRANCH:-main}"

if ! command -v nix >/dev/null 2>&1; then
    if [ "${NIX_INSTALLED}" ]; then
        echo "Nix is not found even after installing it and running a new shell"
        exit 1;
    fi
    curl -fsSL https://raw.githubusercontent.com/ksauder/nix-home/refs/heads/${BRANCH}/install_nix.sh | bash
    export NIX_INSTALLED=1
    exec /bin/sh -l "$0" "$@"
fi

arch="$(uname -m)"
os="$(uname -s | tr '[:upper:]' '[:lower:]')"

export HOMEREPO_DIR=~/.nixhome
nix \
    --extra-experimental-features nix-command \
    --extra-experimental-features flakes \
    run home-manager/master -- \
    --extra-experimental-features nix-command \
    --extra-experimental-features flakes \
    switch --flake ~/.nixhome#kyle@${arch}-${os}
