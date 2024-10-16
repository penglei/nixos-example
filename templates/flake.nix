{
  description = "nixos configuration example";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils, ... }:
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
          ];
        };
      });

    };
}
