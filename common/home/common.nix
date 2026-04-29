{ config, pkgs, lib, ... }:

{
  home.stateVersion = "25.11";
  home.packages = [
    pkgs.nerd-fonts.fira-mono
    pkgs.nerd-fonts.hack
    pkgs.spotify
    pkgs.exiftool
  ];

  programs.starship.enable = true;
  programs.direnv.enable = true;
  fonts.fontconfig.enable = true;

  imports = [
    ./programs/zsh.nix
    ./programs/git.nix
  ];
}
