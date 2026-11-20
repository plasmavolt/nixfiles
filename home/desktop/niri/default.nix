{
  config,
  pkgs,
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

    screenshot-path = "${config.xdg.userDirs.pictures}/screenshots/screenshot-%Y-%m-%d-%H-%M-%S.png";

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
        accel-profile = "flat";
      };
      keyboard = {
        repeat-delay = 225;
        repeat-rate = 33;
      };
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
        matches = [ { app-id = "^org\\.pwmt\\.zathura$"; } ];
        opacity = 0.92;
        background-effect.blur = true;
      }
      {
        matches = [ { app-id = "^org\\.qutebrowser\\.qutebrowser$"; } ];
        background-effect.blur = false;
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
