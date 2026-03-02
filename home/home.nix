{ config, pkgs, lib, ... }:

{
  programs.zsh = {
    enable = true;
    shellAliases = {
      cat = "bat --style=header,grid";
      ls = "lsd";
      la = "ls -A";
      ll = "ls -l";
      l = "ls -CF";
      lg = "lazygit";
      tf = "terraform";
      k = "kubectl";
      ts = "tmux-start";
      vim = "nvim";
      dockernuke = "docker system prune --volumes -f -a";
      git-prune-local-branches = "git fetch -p; git branch -vv | grep \": gone]\" | grep -v \"\*\" | awk '{ print $1; }' | xargs -r git branch -D";
    };
    initContent = ''
      # eval "$(fnm env --use-on-cd --shell zsh)"
      # ... rest of your shell config
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "extract"
        "ssh-agent"
      ];
      theme = "aussiegeek";
    };
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Kyle Sauder";
      user.email = "ksauder@gmail.com";
      push.autoSetupRemote = true;
    };
  };

  #programs.starship.enable = true;

  home.stateVersion = "25.11";
}
