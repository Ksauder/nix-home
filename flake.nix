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
          ./hosts/olembp/configuration.nix
          home-manager.darwinModules.home-manager
          {
            users.users.kylesauder = {
              name = "kylesauder";
              home = "/Users/kylesauder/";
            };
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupCommand = "echo";
              users.kylesauder = import ./home/home.nix;
            };
          }
        ];
      };
    };
}
