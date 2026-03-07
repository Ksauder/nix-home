{ pkgs, ... }:

{
  system.primaryUser = "kylesauder";

  # CLI tools (replaces brew install)
  environment.systemPackages = with pkgs; [
    bat fzf delta gh lazygit lsd ripgrep tree direnv curl wget iftop jq nmap
  ];

  # GUI apps (declarative Homebrew)
  homebrew = {
    enable = true;
    #onActivation.cleanup = "zap";
    casks = [ "raycast" "slack" "linear-linear" "ghostty" ];
  };

  # macOS preferences
  system.defaults = {
    dock.autohide = true;
    finder.AppleShowAllFiles = true;
    NSGlobalDomain.KeyRepeat = 2;
  };

  # Determinate installer manages Nix itself
  nix.enable = false;

  programs = {
    gnupg.agent.enable = true;
    zsh.enable = true;
  };

  system.stateVersion = 5;
  nixpkgs.hostPlatform = "aarch64-darwin";
}
