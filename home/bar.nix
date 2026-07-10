{ config, ... }:

{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      targets = [ "niri.service" ];
    };
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 32;
        margin-top = 8;
        margin-left = 8;
        margin-right = 8;
        border-radius = 8;
        modules-left = [
          "niri/workspaces"
          "niri/window"
        ];
        modules-right = [
          "pulseaudio"
          "backlight"
          "network"
          "battery"
          "clock"
        ];

        # --- module config ---

        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-muted = "MUTED";
          on-click = "pavucontrol";
        };
      };
    };
    style = with config.lib.stylix.colors; ''
            window#waybar {
              background: alpha(#${base01}, 0.9);
            }
            #battery.warning { color: #${base09}; }
            #battery.critical { color: #${base08}; }
            #workspaces button.focused {
              background: #${base0D};
      	color: #${base00};
            }
    '';
  };
}
