{ inputs }:

let
  inherit (inputs)
    nixpkgs
    home-manager
    niri
    stylix
    ;
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
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        (
          { pkgs, ... }:
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            # keep backup when .hm-bak exists
            home-manager.backupCommand = pkgs.writeShellScript "home-manager-backup" ''
              backup="$(${pkgs.coreutils}/bin/mktemp -- "$1.hm-bak.XXXXXX")"
              ${pkgs.coreutils}/bin/mv -- "$1" "$backup"
            '';
            home-manager.extraSpecialArgs = { inherit inputs hostname; };
            home-manager.users.frank = import ../home/frank.nix;
          }
        )
      ]
      ++ extraModules;
    };
}
