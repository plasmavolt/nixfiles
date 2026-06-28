{ lib, hostname, ... }:

{
  imports = [
    ./binds.nix
  ];
  programs.niri.settings = {
    prefer-no-csd = true; # no title bars

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
