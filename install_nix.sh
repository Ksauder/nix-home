#!/bin/sh

ERRSTR=""
if ! command bash --version >/dev/null 2>&1; then
    ERRSTR="${ERRSTR}- Install bash\n"
fi

if ! command curl --version >/dev/null 2>&1; then
    ERRSTR="${ERRSTR}- Install curl\n"
fi
if ! command xz --version >/dev/null 2>&1; then
    ERRSTR="${ERRSTR}- Install xz\n"
fi

if [ "$ERRSTR" ]; then
    echo "ERROR: requirements not met:"
    echo -e "$ERRSTR"
    exit 1
fi

curl -L https://nixos.org/nix/install | sh -s -- --daemon
mkdir -p ~/.config/nix
echo 'experimental-features = nix-command flakes' >> ~/.config/nix/nix.conf

