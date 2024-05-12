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
      mixNixDeps = import ./deps.nix {
        inherit (pkgs) lib beamPackages;
      };
      postBuild = ''
        mkdir -p $out/lib/${pname}-${version}/priv
        cp -r priv $out/lib/${pname}-${version}/priv
        cp -r assets $out/lib/${pname}-${version}/priv/static
      '';
    };
  };
}
