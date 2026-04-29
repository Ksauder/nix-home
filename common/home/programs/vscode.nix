{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      yzhang.markdown-all-in-one
      nuxtr.nuxt-vscode-extentions
      ms-vscode-remote.vscode-remote-extensionpack
    ];
  };
}
