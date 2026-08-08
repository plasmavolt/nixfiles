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
        margin-top = 6;
        margin-left = 8;
        margin-right = 8;
        # spacing between modules handled by per-module margins in CSS
        spacing = 0;
        modules-left = [
          "niri/workspaces"
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

        "niri/workspaces" = {
          format = "{index}";
        };

        "pulseaudio" = {
          format = "{icon}  {volume}%";
          format-muted = "󰝟  muted";
          format-bluetooth = "󰂰  {volume}%";
          format-bluetooth-muted = "󰂲  muted";
          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
            headphone = "󰋋";
            headset = "󰋎";
            hands-free = "󰋎";
            phone = "󰏲";
            portable = "󰦧";
            car = "󰄋";
            speaker = "󰓃";
            hdmi = "󰡁";
          };
          tooltip-format = "{desc} — {volume}%";
          on-click = "pavucontrol";
          on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0";
          on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
        };

        "backlight" = {
          format = "{icon}  {percent}%";
          format-icons = [
            "󰃞"
            "󰃟"
            "󰃝"
            "󰃠"
          ];
          tooltip-format = "Brightness {percent}%";
          on-scroll-up = "brightnessctl set 5%+";
          on-scroll-down = "brightnessctl set 5%-";
        };

        "network" = {
          interval = 5;
          format-wifi = "{icon}  {essid}";
          format-ethernet = "󰈀  wired";
          format-linked = "󰈁  {ifname}";
          format-disconnected = "󰤭  offline";
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
          tooltip-format = "󰩠  {ipaddr}/{cidr}\n󰕒  {bandwidthUpBits}  󰇚  {bandwidthDownBits}";
          tooltip-format-wifi = "{essid} ({signalStrength}%)\n󰩠  {ipaddr}";
          tooltip-format-disconnected = "Disconnected";
        };

        "battery" = {
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon}  {capacity}%";
          format-charging = "󰂄  {capacity}%";
          format-plugged = "󰚥  {capacity}%";
          format-full = "󰁹  full";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
          tooltip-format = "{timeTo} ({capacity}%)";
        };

        "clock" = {
          format = "󰥔  {:%H:%M}";
          format-alt = "󰃭  {:%a, %b. %d  %H:%M}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
          calendar = {
            mode = "month";
            format = {
              today = "<b><u>{}</u></b>";
            };
          };
        };

        "custom/swaync" = {
          tooltip = false;
          format = "{icon}";
          format-icons = {
            notification = "󱅫";
            none = "󰂚";
            dnd-notification = "󰂛";
            dnd-none = "󰂛";
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
      * {
        font-family: "${config.stylix.fonts.monospace.name}";
        font-size: 10pt;
        min-height: 0;
      }

      window#waybar {
        background: transparent;
        border-radius: 0;
      }

      /* ---- island base ---- */
      #workspaces,
      #custom-swaync,
      #pulseaudio,
      #backlight,
      #network,
      #battery,
      #clock {
        background: alpha(#${base00}, 0.84);
        color: #${base05};
        border: 1px solid alpha(#${base03}, 0.55);
        border-radius: 10px;
        padding: 2px 12px;
        margin: 0 3px;
      }

      /* first / last islands hug the screen edges a little less */
      .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
      }

      .modules-right > widget:last-child > #clock {
        margin-right: 0;
      }

      /* ---- workspaces ---- */
      #workspaces {
        padding: 2px 6px;
      }

      #workspaces button {
        all: unset;
        color: #${base04};
        padding: 0 8px;
        margin: 0 1px;
        border: none;
        border-radius: 8px;
        transition: background 150ms ease, color 150ms ease;
      }

      #workspaces button:hover {
        background: alpha(#${base02}, 0.84);
        color: #${base05};
      }

      #workspaces button.active,
      #workspaces button.focused {
        background: alpha(#${base0D}, 0.84);
        color: #${base00};
      }

      #workspaces button.urgent {
        background: alpha(#${base08}, 0.84);
        color: #${base00};
      }

      /* ---- per-module accents ---- */
      /* icon-only module: the glyph carries its own left side bearing, so trim
         the left padding to make it look optically even with the others */
      #custom-swaync {
        color: #${base0A};
        padding: 2px 12px 2px 9px;
      }

      #pulseaudio {
        color: #${base0C};
      }

      #pulseaudio.muted {
        color: #${base04};
      }

      #backlight {
        color: #${base0A};
      }

      #network {
        color: #${base0B};
      }

      #network.disconnected {
        color: #${base08};
      }

      #battery {
        color: #${base0B};
      }

      #battery.charging,
      #battery.plugged {
        color: #${base0C};
      }

      #battery.warning:not(.charging) {
        color: #${base09};
      }

      #battery.critical:not(.charging) {
        color: #${base08};
        border-color: #${base08};
      }

      #clock {
        color: #${base0E};
      }

      /* ---- tooltips ---- */
      tooltip {
        background: alpha(#${base00}, 0.84);
        border: 1px solid #${base0D};
        border-radius: 10px;
      }

      tooltip label {
        color: #${base05};
        padding: 4px;
      }
    '';
  };
}
