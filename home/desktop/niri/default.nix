{
  lib,
  pkgs,
  hostname,
  ...
}:

{
  imports = [
    ./binds.nix
    ./lock.nix
  ];

  home.packages = [ pkgs.bibata-cursors ];

  programs.niri.settings = {
    prefer-no-csd = true; # no title bars

    cursor = {
      theme = "Bibata-Modern-Classic";
      size = 18;
    };

    input = {
      mouse = {
        accel-profile = "flat";
      };
      touchpad = {
        tap = false;
        click-method = "clickfinger";
        natural-scroll = true;
        scroll-factor = lib.mkIf (hostname != "ncase") 0.5;
        accel-profile = "flat";
      };
      keyboard = {
        repeat-delay = 225;
        repeat-rate = 33;
      };
    };

    outputs."eDP-1".scale = lib.mkIf (hostname == "framework") 1.5;
    outputs."DP-6" = lib.mkIf (hostname == "ncase") {
      mode = {
        width = 2560;
        height = 1440;
        refresh = 164.999;
      };
      scale = 1.2;
    };

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
        scroll-factor = lib.mkIf (hostname != "ncase") 2.0;
      }
      {
        matches = [ { app-id = "^org\\.pwmt\\.zathura$"; } ];
        opacity = 0.92;
        background-effect.blur = true;
      }
      {
        matches = [ { app-id = "^yazi-file-chooser$"; } ];
        open-floating = true;
        background-effect.blur = true;
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
  };
}
