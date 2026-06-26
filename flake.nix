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
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      };
      formatter.${system} = nixpkgs.legacyPackages.${system}.nixfmt;
    };

}
