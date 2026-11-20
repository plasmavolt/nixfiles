{ lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./nvidia.nix
  ];

  networking.hostName = "ncase";
  boot.kernelPackages = pkgs.linuxPackages;
  swapDevices = lib.mkForce [ ]; # no disk swap

  home-manager.users.frank.programs.niri.settings.outputs."DP-6" = {
    mode = {
      width = 2560;
      height = 1440;
      refresh = 164.999;
    };
    scale = 1.2;
  };

  # firmware updates (fwupdmgr refresh && fwupdmgr update)
  services.fwupd.enable = true;

  # third-party apps (flatpaks, AppImages)
  services.flatpak.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  system.stateVersion = "26.05"; # DO NOT CHANGE
}
