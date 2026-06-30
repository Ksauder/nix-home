macOS support: [nix-darwin](https://mynixos.com/nix-darwin)

this was inspired by:

- [The One Nix](https://frankper.gitlab.io/the-one-nix/)

- <https://evantravers.com/articles/2024/02/06/switching-to-nix-darwin-and-flakes/>
- <https://monogram.io/blog/declarative-macos-with-nix-a-practical-guide>
- <https://davi.sh/blog/2024/02/nix-home-manager/>
- [multi host flake config](https://johns.codes/blog/organizing-system-configs-with-nixos)
- [just deeevin](https://writing.justdeeevin.dev/articles/nixos_walkthrough)

examples:

- [jrm](https://github.com/JRMurr/NixOsConfig/tree/main)

mindcastle/topics/nix/nix_on_macos.md

## Quickstart

this repo should always be found locally at `~/.nixhome`

run `curl -fsSL https://raw.githubusercontent.com/ksauder/nix-home/refs/heads/<BRANCH>/install_home.sh | bash`
to install generic homedir on linux or darwin user `kyle`
run `sudo darwin-rebuild switch --flake .#kyle@olembp` to apply this configuration on M1 MacOS
run `home-manager switch --flake ~/.nixhome#kyle@<arch>-<linux|darwin>` for non host specific homedir management

## Program related references:

- tmux
    - [HM program docs](https://nix-community.github.io/home-manager/options/home-manager/programs/tmux.html#opt-programs.tmux.plugins)
    - [oh my tmux](https://github.com/gpakosz/.tmux)
    - [nix tmuxPlugins package set](https://search.nixos.org/packages?buckets={%22package_attr_set%22:[],%22package_license_set%22:[],%22package_maintainers_set%22:[],%22package_teams_set%22:[],%22package_platforms%22:[]}&channel=26.05&query=tmuxPlugins)

