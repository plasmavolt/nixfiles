{ config, pkgs, ... }:

let
  inherit (config.lib.stylix.colors)
    base00
    base03
    base05
    base08
    base0D
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
          path = "${config.xdg.stateHome}/waypaper/current-wallpaper";
          blur_passes = 3;
          blur_size = 8;
          brightness = 0.32;
          color = "rgba(${base00}aa)";
        }
      ];

      input-field = [
        {
          monitor = "";
          size = "360, 54";
          outline_thickness = 0;
          inner_color = "rgba(${base00}66)";
          outer_color = "rgba(${base00}00)";
          check_color = "rgba(${base0D}ff)";
          fail_color = "rgba(${base08}ff)";
          fail_text = "incorrect";
          fail_transition = 150;
          font_color = "rgb(${base05})";
          font_family = font;
          placeholder_text = "password";
          rounding = 14;
          dots_center = true;
          dots_size = 0.18;
          dots_spacing = 0.18;
          fade_on_empty = false;
          position = "0, -76";
          halign = "center";
          valign = "center";
        }
      ];

      shape = [ ];

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
          color = "rgb(${base0D})";
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
