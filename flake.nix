{
  description = "frank's nixos config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pi = {
      url = "github:lukasl-dev/pi.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    osu-lazer.url = "github:repinek/osu-lazer-flake";
  };

  outputs =
    {
      self,
      nixpkgs,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      frankLib = import ./lib { inherit inputs; };
    in
    {
      nixosConfigurations = {
        framework = frankLib.mkHost {
          hostname = "framework";
          system = system;
        };
        ncase = frankLib.mkHost {
          hostname = "ncase";
          system = system;
        };
      };
      apps.${system}.osu-lazer = {
        type = "app";
        program = "${inputs.osu-lazer.packages.${system}.osu-lazer-bin}/bin/osu!";
      };
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;
    };

}
