{ lib, hostname, ... }:

{
  imports = [
    ./binds.nix
    ./lock.nix
  ];

  programs.niri.settings = {
    prefer-no-csd = true; # no title bars

    input = {
      touchpad = {
        tap = false;
        natural-scroll = true;
        scroll-factor = 0.5;
      };
      keyboard = {
        repeat-delay = 225;
        repeat-rate = 33;
      };
    };

    outputs."eDP-1".scale = lib.mkIf (hostname == "framework") 1.5;

    layout = {
      border = {
        enable = true;
        width = 1;
      };
      gaps = 8;
    };

    window-rules = [
      {
        geometry-corner-radius =
          let
            radius = 8.0;
          in
          {
            top-left = radius;
            top-right = radius;
            bottom-left = radius;
            bottom-right = radius;
          };
        clip-to-geometry = true;
        background-effect = {
          blur = true;
        };
        popups = {
          background-effect = {
            blur = true;
          };
        };
      }
      {
        matches = [ { app-id = "foot"; } ];
        scroll-factor = 2.0;
      }
    ];

    layer-rules = [
      {
        background-effect = {
          blur = true;
        };
        popups = {
          background-effect = {
            blur = true;
          };
        };
      }
    ];

    spawn-at-startup = [ { command = [ "xwayland-satellite" ]; } ];
  };
}
