{ lib, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./configuration.nix
    ./nvidia.nix
  ];

  # hardware-configuration.nix has a stale encrypted swap mapper entry that
  # is not unlocked, causing a boot-time wait for the mapper to time out.
  # zram swap is already enabled globally, so disable disk swap on ncase.
  swapDevices = lib.mkForce [ ];
}
