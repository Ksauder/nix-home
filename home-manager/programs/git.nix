{ config, pkgs, ... }:
# could add another home-manager specialArg to get user name and email externally

{
  programs.git = {
    enable = true;
    settings = {
      user.name = "Kyle Sauder";
      user.email = "ksauder@gmail.com";
      push.autoSetupRemote = true;
    };
  };
}
