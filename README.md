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

this repo should always be found locally at `~/.nixhome`

run `curl -fsSL https://raw.githubusercontent.com/ksauder/nix-home/refs/heads/<BRANCH>/install_home.sh | bash`
    to install generic homedir on linux or darwin user `kyle`
run `sudo darwin-rebuild switch --flake .#kyle@olembp` to apply this configuration on M1 MacOS
run `home-manager switch --flake ~/.nixhome#kyle@<arch>-<linux|darwin>` for non host specific homedir management

## Issues

- [x] figure out how to manage dotfiles in a "non nix" way (copy or link them with proper permissions)
    - https://discourse.nixos.org/t/deploy-files-into-home-directory-with-home-manager/24018/4
    - https://www.reddit.com/r/NixOS/comments/106jpy5/best_way_to_setup_nvim_on_nixos/
    - https://www.foodogsquared.one/posts/2023-03-24-managing-mutable-files-in-nixos/
    - This can be done using an env var and `--impure` or just setting a hardcoded location currently `~/.nixhome`
        as the `flakeDir` and then setting `dofilesDir` as `"${flakeDir}/dotfiles"`. As long as this repo is cloned
        to `~/.nixhome` I can use `dotfilesDir` to reference the locaion in activation scripts for linking to
        `~/.nixhome/dotfiles` editable files. It's impure, yadayada, and it works.
        For certain apps like nvim this can be useful so I can use lazyvim and the like, and if I need dotfiles to
        be managed by HM but also potentially be useable with a simple clone and stow method in other envs, then
        it may be nice to link all dotfiles this way. The other option is use the dotfiles so I can have a home dir
        outside HM, but have a workflow that keeps them uneditable when managed by HM.
- [ ] convert all (most?) dotfile configurations to nix? Does my workflow allow me to use nix everywhere? I may
    want to keep most configs as dotfiles and just link them.
- [ ] seeing a zsh compinit permission issue on wsl2 debian after making a `kyle` user with existing `dev` user as 1001:
```
[oh-my-zsh] Insecure completion-dependent directories detected:
lrwxrwxrwx 1 root root 64 Dec 31  1969 /nix/var/nix/profiles/default/share/zsh -> /nix/store/fla7gi1dvkw4hvwxar8m7z25p2yv7r40-nix-2.34.7/share/zsh
```
- [ ] `--extra-experimental-features flakes` and `--extra-experimental-features nix-command`
- [ ] hitting escape in nvim is laggy when used in tmux
    - [change escape-time setting in tmux](https://neovim.io/doc/user/faq/#_esc-in-tmux-or-gnu-screen-is-delayed)
