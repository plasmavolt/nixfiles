{ config, pkgs, ... }:

let
  inherit (config.lib.stylix.colors)
    base00
    base03
    base05
    base08
    base0B
    ;
  font = config.stylix.fonts.monospace.name;
in
{
  stylix.targets.hyprlock.enable = false;

  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        hide_cursor = true;
        ignore_empty_input = true;
      };

      animations.enabled = false;

      background = [
        {
          monitor = "";
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
          brightness = 0.7;
          color = "rgba(${base00}66)";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "360, 52";
          outline_thickness = 0;
          inner_color = "rgba(${base00}00)";
          outer_color = "rgba(${base00}00)";
          check_color = "rgba(${base05}ff)";
          fail_color = "rgba(${base08}ff)";
          fail_text = "$FAIL";
          fail_transition = 0;
          font_color = "rgb(${base05})";
          font_family = font;
          placeholder_text = "";
          rounding = 0;
          dots_center = true;
          dots_size = 0.2;
          dots_spacing = 0.2;
          fade_on_empty = false;
          position = "0, -70";
          halign = "center";
          valign = "center";
        }
      ];

      shape = [
        {
          monitor = "";
          size = "360, 1";
          color = "rgba(${base03}cc)";
          rounding = 0;
          position = "0, -96";
          halign = "center";
          valign = "center";
        }
      ];

      label = [
        {
          monitor = "";
          text = "cmd[update:1000] date '+%H:%M'";
          color = "rgb(${base05})";
          font_size = 48;
          font_family = font;
          position = "0, 70";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:60000] date '+%a, %b %d' | tr '[:upper:]' '[:lower:]'";
          color = "rgb(${base0B})";
          font_size = 16;
          font_family = font;
          position = "0, 20";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };

  # idle handling
  services.swayidle = {
    enable = true;
    events = {
      before-sleep = "${pkgs.hyprlock}/bin/hyprlock";
      lock = "${pkgs.hyprlock}/bin/hyprlock";
    };
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.hyprlock}/bin/hyprlock";
      }
      {
        timeout = 600;
        command = "niri msg action power-off-monitors";
        resumeCommand = "niri msg action power-on-monitors";
      }
    ];
  };

  programs.niri.settings.binds = {
    "Mod+Escape" = {
      allow-when-locked = true;
      action.spawn = "${pkgs.hyprlock}/bin/hyprlock";
    };
  };
}
