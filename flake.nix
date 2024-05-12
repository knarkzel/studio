{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {
      inherit system;
    };
    beamPackages = pkgs.beamPackages;
  in {
    packages.${system}.default = beamPackages.mixRelease {
      src = ./.;
      pname = "studio";
      version = "0.1.0";
      MIX_ENV = "prod";
      mixNixDeps = import ./deps.nix {
        inherit (pkgs) lib beamPackages;
      };
    };
  };
}
