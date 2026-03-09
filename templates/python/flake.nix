# this was created because I read this:
# https://pyproject-nix.github.io/uv2nix/usage/getting-started.html
{
  description = "My project dev environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    uv2nix.url = "github:pyproject-nix/uv2nix";
    pyproject-nix = {
      url = "github:pyproject-nix/pyproject.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, flake-utils, uv2nix, pyproject-nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = nixpkgs.legacyPackages.${system};
        python = pkgs.python313;

        workspace = uv2nix.lib.workspace.loadWorkspace {
          workspaceRoot = ./.;
        };

        overlay = workspace.mkPyprojectOverlay {
          sourcePreference = "wheel";
        };

        pythonSet = (pkgs.callPackage pyproject-nix.lib.renderers.withPackages {
          inherit python;
        }).overrideScope overlay;
      in {
        # Reproducible app package
        packages.default = pythonSet.mkVirtualEnv "sample_app" 
          workspace.deps.default;

        # Dev shell
        devShells.default = pkgs.mkShell {
          packages = [ python pkgs.uv ];
          UV_PYTHON = "${python}/bin/python";
          shellHook = ''
            uv sync
            source .venv/bin/activate
          '';
        };
      });
}
