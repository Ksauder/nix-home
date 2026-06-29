{ config, pkgs, lib, ... }:

{
  home.username = "kyle";
  home.homeDirectory = if pkgs.stdenv.isDarwin
    then /Users/kyle
    else /home/kyle;
  imports = [
    ./common.nix
  ];
}
