{ config, pkgs, lib, username, ... }:

{
  home.username = username;
  home.homeDirectory = /. + builtins.toPath "/home/${username}"
  imports = [
    ./common.nix
  ];
}
