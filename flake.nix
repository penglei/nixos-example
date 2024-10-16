{
  description = "NixOS flake configuration example";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, flake-utils, ... }:
    let
      username = "penglei";
      hostname = "mynixos";
    in {
      packages = flake-utils.lib.eachDefaultSystemMap (system: {
        nixosConfigurations."${hostname}" = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit nixpkgs username hostname; };
          modules = [
            ./configuration.nix
            ./hardware.nix # should match target machine
            ./nix.nix
          ];
        };
      });

      templates = {
        default = {
          path = ./templates;
          description = "simplest generic NixOS flake configuration";
        };
      };
    };
}

