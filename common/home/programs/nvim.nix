{ config, pkgs, lib, dotfilesDir, ... }:

{
  home.packages = [ pkgs.neovim ];
  home.activation.linkNvimConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ln -sfn ${dotfilesDir}/nvim/.config/nvim $HOME/.config/nvim
  '';
}
