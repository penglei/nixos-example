{ pkgs, nixpkgs, username, ... }:

{
  nix = {
    package = pkgs.nixVersions.git;
    registry.nixpkgs.flake = nixpkgs;
    gc.automatic = true;
    settings = {
      auto-optimise-store = true;
      use-cgroups = true; # support for running builds inside a cgroup
      warn-dirty = false;
      auto-allocate-uids = true;
      experimental-features =
        [ "nix-command" "flakes" "auto-allocate-uids" "cgroups" ];
      trusted-users = [ "@wheel" username ];
    };
  };
}

