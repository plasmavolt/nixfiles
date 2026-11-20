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
      nixpkgs,
      home-manager,
      niri,
      stylix,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      mkHost =
        hostModule:
        nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = { inherit inputs; };
          modules = [
            hostModule
            ./modules/nixos
            niri.nixosModules.niri
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
          ];
        };
    in
    {
      nixosConfigurations = {
        framework = mkHost ./hosts/framework/configuration.nix;
        ncase = mkHost ./hosts/ncase/configuration.nix;
      };
      apps.${system}.osu-lazer = {
        type = "app";
        program = "${inputs.osu-lazer.packages.${system}.osu-lazer-bin}/bin/osu!";
      };
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;
    };
}
