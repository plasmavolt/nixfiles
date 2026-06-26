{ inputs }:

let
  inherit (inputs) nixpkgs home-manager niri;
in
{
  mkHost =
    {
      system ? "x86_64-linux",
      hostname,
      extraModules ? [ ],
    }:
    nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = { inherit inputs hostname; };
      modules = [
        ../hosts/${hostname}
        ../modules/nixos
        niri.nixosModules.niri
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs hostname; };
          home-manager.users.frank = import ../home/frank.nix;
        }
      ]
      ++ extraModules;
    };
}
