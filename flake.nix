{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { nixpkgs, ... }: let
    src = ./.;
    pname = "studio";
    system = "x86_64-linux";
    version = "0.1.0";
    MIX_ENV = "prod";
    pkgs = import nixpkgs {
      inherit system;
    };
    beamPackages = pkgs.beamPackages;
  in {
    packages.${system}.default = beamPackages.mixRelease {
      inherit src pname version MIX_ENV;
      MIX_TAILWIND_PATH = "${pkgs.tailwindcss}/bin/tailwindcss";
      MIX_ESBUILD_PATH = "${pkgs.esbuild}/bin/esbuild";
      mixNixDeps = import ./deps.nix {
        inherit (pkgs) lib beamPackages;
      };
      postBuild = ''
        mix do deps.loadpaths --no-deps-check, assets.deploy
      '';
    };
  };
}
