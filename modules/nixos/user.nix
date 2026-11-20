{
  config,
  inputs,
  pkgs,
  ...
}:
{
  users.users.frank = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
    initialPassword = "changeme";
  };

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    # keep backups even when .hm-bak exists
    backupCommand = pkgs.writeShellScript "home-manager-backup" ''
      backup="$(${pkgs.coreutils}/bin/mktemp -u -- "$1.hm-bak.XXXXXX")"
      ${pkgs.coreutils}/bin/mv -- "$1" "$backup"
    '';
    extraSpecialArgs = {
      inherit inputs;
      hostname = config.networking.hostName;
    };
    users.frank = ../../home/frank.nix;
  };
}
