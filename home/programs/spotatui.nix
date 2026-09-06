{ inputs, pkgs, ... }:

{
  home.packages = [
    inputs.spotatui.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
