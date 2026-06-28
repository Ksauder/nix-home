{ config, pkgs, lib, dotfiles, ... }:

{
  home.stateVersion = "25.11";
  home.packages = with pkgs; [
    nerd-fonts.fira-mono
    nerd-fonts.hack
    #spotify  # broken currently: server returns 429
    exiftool
    just        # justfile recipe tool cli
    lazydocker
    lazygit
    bat         # better `cat`
    fzf
    delta
    gh          # github cli
    lsd         # fancy ls
    ripgrep
    tree
    direnv
    curl
    wget
    iftop       # interface top
    jq
    nmap
  ];

  programs.home-manager.enable = true;
  programs.starship.enable = true;
  programs.direnv.enable = true;
  fonts.fontconfig.enable = true;

  home.shellAliases.home-manager = "home-manager -b hmbak";
  imports = [
    ./programs/zsh.nix
    ./programs/git.nix
    ./programs/nvim.nix
  ];
}
