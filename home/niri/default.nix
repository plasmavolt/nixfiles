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
      }
      {
        matches = [ { app-id = "dev.noctalia.Noctalia.Settings"; } ];
        open-floating = true;
        default-column-width = {
          fixed = 1080;
        };
        default-window-height = {
          fixed = 920;
        };
      }
    ];

    spawn-at-startup = [
      { command = [ "xwayland-satellite" ]; }
      { command = [ "noctalia" ]; }
    ];

    # todo: add "honor-xdg-activation-with-invalid-serial"
  };
}
