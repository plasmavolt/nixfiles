{ inputs, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
  ];

  networking.hostName = "framework";
  boot.kernelPackages = pkgs.linuxPackages_latest;
  hardware.framework.enableKmod = false;

  home-manager.users.frank = {
    local.desktop.lockTimeout = 120;
    programs.niri.settings = {
      input.touchpad.scroll-factor = 0.5;
      outputs."eDP-1".scale = 1.5;
      window-rules = [
        {
          matches = [ { app-id = "foot"; } ];
          scroll-factor = 2.0;
        }
      ];
    };
  };

  system.stateVersion = "26.05"; # DO NOT CHANGE
}
