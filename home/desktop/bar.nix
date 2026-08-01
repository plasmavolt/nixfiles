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
        modules-left = [
          "niri/workspaces"
          "niri/window"
        ];
        modules-right = [
          "custom/swaync"
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

        "custom/swaync" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "";
            none = "";
            dnd-notification = "";
            dnd-none = "";
          };
          return-type = "json";
          exec-if = "which swaync-client";
          exec = "swaync-client -swb";
          on-click = "swaync-client -t -sw";
          on-click-right = "swaync-client -d -sw";
          escape = true;
        };
      };
    };
    style = with config.lib.stylix.colors; ''
      window#waybar {
        background: alpha(#${base00}, 0.9);
        border-radius: 8px;
      }

      #battery.warning {
        color: #${base09};
      }

      #battery.critical {
        color: #${base08};
      }

      #workspaces button.focused {
        background: #${base0D};
        color: #${base00};
      }
    '';
  };
}
