{ config, pkgs, ... }:

let
  hmsFunction = ''
    hms() {
      if [ -z "$1" ]; then
        echo '$0 <target>'
      else
        home-manager \
          --extra-experimental-features nix-command \
          --extra-experimental-features flakes \
          switch --flake ~/.nixhome#$1
        exec zsh -l
      fi
    }
  '';
in
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
    '' + hmsFunction;
    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "extract"
        "ssh-agent"
        "direnv"
      ];
      theme = "aussiegeek";
    };
  };
}
