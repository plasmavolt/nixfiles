{ lib, hostname, ... }:

{
  imports = [
    ./binds.nix
  ];
  programs.niri.settings = {
    input = {
      touchpad = {
        tap = true;
        natural-scroll = true;
      };
      keyboard = {
        repeat-delay = 225;
        repeat-rate = 33;
      };
    };

    outputs."eDP-1".scale = lib.mkIf (hostname == "framework") 1.5;

    spawn-at-startup = [
      { command = [ "xwayland-satellite" ]; }
    ];
  };
}
