{ inputs, ... }:
{
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-amd-ai-300-series
  ];
}
