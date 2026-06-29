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
  let
    kyleHome = {
      imports = [ ./common/home/kyle.nix ];
    };
    # requires impure and must be properly set as the dir holding this flake
    #flakeDir = assert builtins.getEnv "FLAKE_DIR" != "" || abort "Set FLAKE_DIR"; builtins.getEnv "FLAKE_DIR";
    flakeDir = "~/.nixhome";
    # with an 'impure' flakeDir set, we can link editable dotfiles from ./dotfiles
    dotfilesDir = "${flakeDir}/dotfiles";
    makeStandaloneHome = { system, username ? "kyle" }:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        module = if system == "aarch64-darwin" then ./common/home/darwin.nix else ./common/home/linux.nix;
      in
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit dotfilesDir username; };
        modules = [
          module
          { nixpkgs.config.allowUnfree = true; }
        ];
      };
  in {
    # https://nix-darwin.github.io/nix-darwin/manual/
    #inputs.nixpkgs.config.unfree = true;
    darwinConfigurations."kylesauder@olembp" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./hosts/olembp/default.nix
        { nixpkgs.config.allowUnfree = true; }
        home-manager.darwinModules.home-manager
        {
          # setting the users.users fixes the homeDirectory being null when needed by zsh.nix
          # I just need to better understand the options and the difference between modules/imports and when things are resolved
          users.users.kylesauder = {
            name = "kylesauder";
            home = /Users/kylesauder;
          };
          home-manager = {
            extraSpecialArgs = { inherit dotfilesDir; };
            useGlobalPkgs = true;
            useUserPackages = true;
            users.kylesauder = {
              imports = [ ./common/home/darwin.nix ];
            };
          };
        }
      ];
    };
    systemConfigurations."kyle@rgb" = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      users.users.kyle = {
        name = "kyle";
        home = "/home/kyle/";
      };
      modules = [
        ./hosts/rgb/default.nix
        { nixpkgs.config.allowUnfree = true; }
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
    homeConfigurations = {
      "kyle@x86_64-linux" = makeStandaloneHome { system = "x86_64-linux"; };
      "kyle@aarch64-darwin" = makeStandaloneHome { system = "aarch64-darwin"; };
      "kyle@aarch64-linux" = makeStandaloneHome { system = "aarch64-linux"; };
    };
  };
}
