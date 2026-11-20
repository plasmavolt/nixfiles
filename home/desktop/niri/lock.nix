{
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (config.lib.stylix.colors)
    base00
    base03
    base05
    base08
    base0D
    ;
  font = config.stylix.fonts.monospace.name;
  coreutils = "${pkgs.coreutils}/bin";

  inherit (config.local.desktop) lockTimeout;

  niri = "${config.programs.niri.package}/bin/niri";

  # below are llm-generated fixes for some hyprlock bugs i was encountering.
  # didn't really feel like debugging this :/

  # only start hyprlock if it isn't already running. it's spawned through niri
  # so this script returns immediately: swayidle runs with -w and blocks on its
  # commands, so running hyprlock directly would freeze swayidle while locked
  # and replay queued idle events (relocking) after unlock
  lock = pkgs.writeShellScript "lock" ''
    ${pkgs.procps}/bin/pgrep -x hyprlock >/dev/null && exit 0
    ${niri} msg action spawn -- ${pkgs.hyprlock}/bin/hyprlock
  '';

  # give hyprlock a moment to grab the session lock before suspending
  lockBeforeSleep = pkgs.writeShellScript "lock-before-sleep" ''
    ${lock}
    ${coreutils}/sleep 1
  '';
in
{
  options.local.desktop.lockTimeout = lib.mkOption {
    type = lib.types.ints.positive;
    default = 600;
    description = "Number of seconds idle before locking Niri session.";
  };

  config = {
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
            text = "cmd[update:1000] ${coreutils}/date '+%H:%M'";
            color = "rgb(${base05})";
            font_size = 48;
            font_family = font;
            position = "0, 70";
            halign = "center";
            valign = "center";
          }
          {
            monitor = "";
            text = "cmd[update:60000] ${coreutils}/date '+%a, %b %d' | ${coreutils}/tr '[:upper:]' '[:lower:]'";
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
        before-sleep = "${lockBeforeSleep}";
        lock = "${lock}";
      };
      timeouts = [
        {
          timeout = lockTimeout;
          command = "${lock}";
        }
        {
          timeout = lockTimeout + 300;
          command = "${niri} msg action power-off-monitors";
          resumeCommand = "${niri} msg action power-on-monitors";
        }
      ];
    };

    programs.niri.settings.binds = {
      "Mod+Escape" = {
        allow-when-locked = true;
        action.spawn = "${lock}";
      };
    };
  };
}
