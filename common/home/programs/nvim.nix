{ config, pkgs, lib, dotfiles, ... }:

{
  home.packages = [ pkgs.neovim ];
  #home.file.".config/nvim".source = "${dotfiles}/nvim/.config/nvim"; # this links to the store, which is root:root
  home.activation.linkNvimConfig = lib.hm.dag.entryAfter ["writeBoundary"] ''
    ln -sfn ${dotfiles}/nvim/.config/nvim $HOME/.config/nvim
  '';
}
