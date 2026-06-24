{ config, pkgs, lib, dotfiles, ... }:

{
  home.stateVersion = "25.11";
  home.packages = [
    pkgs.nerd-fonts.fira-mono
    pkgs.nerd-fonts.hack
    pkgs.spotify
    pkgs.exiftool
    pkgs.just
    pkgs.lazydocker
    pkgs.lazygit
  ];

  programs.starship.enable = true;
  programs.direnv.enable = true;
  fonts.fontconfig.enable = true;

  home.file = {
    ".testdir".source = "${dotfiles}/dotfiles/nvim/.config/nvim";
  };
  imports = [
    ./programs/zsh.nix
    ./programs/git.nix
  ];
}
