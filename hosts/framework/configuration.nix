{
  pkgs,
  ...
}:

{
  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest; # latest kernel

  # networking
  networking.hostName = "framework"; # define hostname
  networking.networkmanager.enable = true; # configure network w/ nmtui

  system.stateVersion = "26.05"; # DO NOT CHANGE
}
