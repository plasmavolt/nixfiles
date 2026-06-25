{ config, pkgs, ... }:

{
  programs.niri.settings = {
    input.touchpad = {
      tap = true;
      natural-scroll = true;
    };

    outputs."eDP-1".scale = 1.5;

    spawn-at-startup = [
      { command = [ "xwayland-satellite" ]; }
    ];

    binds = with config.lib.niri.actions; {
      "Mod+Return".action = spawn "foot";
      "Mod+Space".action = spawn "fuzzel";
      "Mod+Q".action = close-dinwo;
      "Mod+Shift+E".action = quit;
    };
  };
}
