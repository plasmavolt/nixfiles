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

  # bluetooth
  hardware.bluetooth.enable = true;

  # power
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;

  system.stateVersion = "26.05"; # DO NOT CHANGE
}
