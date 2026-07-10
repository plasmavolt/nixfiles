{ ... }:

{
  imports = [
    ./shell.nix
    ./terminal.nix
    ./editor.nix
    ./niri/default.nix
    ./bar.nix
  ];

  home.username = "frank";
  home.homeDirectory = "/home/frank";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;
}
