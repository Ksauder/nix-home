{
  description = "My nix-darwin configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, nix-darwin, home-manager }:
  {
    # https://nix-darwin.github.io/nix-darwin/manual/
    darwinConfigurations."olembp" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./hosts/olembp/default.nix
        home-manager.darwinModules.home-manager
        {
          users.users.kylesauder = {
            name = "kylesauder";
            home = "/Users/kylesauder";
          };
          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.kylesauder = {
              imports = [ ./common/home/darwin.nix ];
              home.homeDirectory = "/Users/kylesauder";
              home.username = "kylesauder";
            };
          };
        }
      ];
    };
    systemConfigurations."rgb" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      users.users.kyle = {
        name = "kyle";
        home = "/home/kyle/";
      };
      modules = [
        ./hosts/rgb/default.nix

        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs   = true;
            useUserPackages = true;
            users.kyle = {
              imports = [
                ./common/home/nixos.nix
              ];
              home.username    = "kyle";
              home.homeDirectory = "/home/kyle";
            };
          };
        }
      ];
    };
    homeConfigurations = {};
  };
}
