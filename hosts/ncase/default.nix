{ lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
    ./nvidia.nix
  ];

  swapDevices = lib.mkForce [ ];

  boot.kernelPackages = lib.mkForce pkgs.linuxPackages;

  # firmware updates (fwupdmgr refresh && fwupdmgr update)
  services.fwupd.enable = true;

  # third-party apps (flatpaks, AppImages)
  services.flatpak.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };
}
