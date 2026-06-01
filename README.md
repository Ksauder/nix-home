
macOS support: [nix-darwin](https://mynixos.com/nix-darwin)

this was inspired by:

- <https://evantravers.com/articles/2024/02/06/switching-to-nix-darwin-and-flakes/>
- <https://monogram.io/blog/declarative-macos-with-nix-a-practical-guide>
- <https://davi.sh/blog/2024/02/nix-home-manager/>
- [multi host flake config](https://johns.codes/blog/organizing-system-configs-with-nixos)
- [just deeevin](https://writing.justdeeevin.dev/articles/nixos_walkthrough)

examples:

- [jrm](https://github.com/JRMurr/NixOsConfig/tree/main)

mindcastle/topics/nix/nix_on_macos.md

## Quickstart

run `sudo darwin-rebuild switch --flake .#olembp` to apply this configuration

## Scratch

Home-manager:

- home config object thing

nix-darwin:

- darwinConfigthing

nixos:

- nixconfigthing

## Todos

- [ ] split out the home-manager configuration so it can be used separately
    I want to manage my dotfiles more generally with HM, so part or all of the
    HM configuration needs to be separate so I can use dotfiles on other machines.
    Not sure if this must be a separate repo, or just a separate file hierarchy in this
    repo.
- [ ] get this configuration loadable/working on rgb
