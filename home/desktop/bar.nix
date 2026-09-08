{ config, ... }:

let
  colors = config.lib.stylix.colors;
  # Pango markup so the value reads in accent color while the label stays muted.
  accent = text: "<span color='#${colors.base0D}'>${text}</span>";
in
{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
      targets = [ "niri.service" ];
    };
    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 30;
      spacing = 0;
      modules-left = [
        "cpu"
        "memory"
        "niri/workspaces"
      ];
      modules-right = [
        "network"
        "pulseaudio"
        "backlight"
        "battery"
        "clock"
      ];

      "niri/workspaces" = {
        format = "{icon}";
        # Waybar's label mapping also accepts ordinary text, not just icons.
        format-icons = {
          "1" = "α";
          "2" = "β";
          "3" = "γ";
          "4" = "δ";
          "5" = "ε";
          "6" = "ζ";
          "7" = "η";
          "8" = "θ";
          "9" = "ι";
          "10" = "κ";
          "11" = "λ";
          "12" = "μ";
          "13" = "ν";
          "14" = "ξ";
          "15" = "ο";
          "16" = "π";
          "17" = "ρ";
          "18" = "σ";
          "19" = "τ";
          "20" = "υ";
          "21" = "φ";
          "22" = "χ";
          "23" = "ψ";
          "24" = "ω";
        };
      };

      pulseaudio = {
        format = "VOL ${accent "{volume:02}%"}";
        format-muted = "VOL OFF";
        format-bluetooth = "BT ${accent "{volume:02}%"}";
        format-bluetooth-muted = "BT OFF";
        tooltip-format = "{desc} — {volume}%";
        on-click = "pavucontrol";
        on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0";
        on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
      };

      backlight = {
        format = "BRT ${accent "{percent:02}%"}";
        tooltip-format = "Brightness {percent}%";
        on-scroll-up = "brightnessctl set 5%+";
        on-scroll-down = "brightnessctl set 5%-";
      };

      network = {
        interval = 5;
        format-wifi = "WLAN ${accent "{signalStrength:02}%"}";
        format-ethernet = "LAN";
        format-linked = "NET LINK";
        format-disconnected = "NET OFF";
        tooltip-format = "{ifname}: {ipaddr}/{cidr}\nUP {bandwidthUpBits} / DN {bandwidthDownBits}";
        tooltip-format-wifi = "{essid} ({signalStrength}%)\n{ipaddr}/{cidr}\nUP {bandwidthUpBits} / DN {bandwidthDownBits}";
        tooltip-format-disconnected = "Disconnected";
      };

      cpu = {
        interval = 5;
        format = "CPU ${accent "{usage:02}%"}";
        tooltip = false;
      };

      memory = {
        interval = 5;
        format = "RAM ${accent "{percentage:02}%"}";
        tooltip-format = "{used:0.1f} / {total:0.1f} GiB used";
      };

      battery = {
        states = {
          warning = 30;
          critical = 15;
        };
        format = "BAT ${accent "{capacity:02}%"}";
        # Plain text in low states so the CSS warning colors apply to the number too.
        format-warning = "BAT {capacity:02}%";
        format-critical = "BAT {capacity:02}%";
        # One indicator for any plugged-in state; charging vs. full is not interesting.
        format-charging = "AC ${accent "{capacity:02}%"}";
        format-plugged = "AC ${accent "{capacity:02}%"}";
        format-full = "AC ${accent "{capacity:02}%"}";
        tooltip-format = "{timeTo} ({capacity:02}%)";
      };

      clock = {
        format = "{:%a, %b. %d  ${accent "%H:%M"}}";
        format-alt = "{:%Y-%m-%d  %H:%M}";
        tooltip-format = "<tt><small>{calendar}</small></tt>";
        calendar = {
          mode = "month";
          format.today = "<b><u>{}</u></b>";
        };
      };
    };

    style = with colors; ''
      * {
        font-family: "${config.stylix.fonts.monospace.name}";
        font-size: 10pt;
        min-height: 0;
        border-radius: 0;
      }

      window#waybar {
        background: alpha(#${base00}, ${toString config.stylix.opacity.desktop});
        color: #${base05};
        border-bottom: 1px solid alpha(#${base03}, 0.5);
      }

      #workspaces {
        margin: 0 8px;
      }

      #workspaces button {
        all: unset;
        color: #${base0D};
        padding: 0 10px;
        border-bottom: 2px solid transparent;
      }

      #workspaces button:hover {
        background: #${base02};
      }

      #workspaces button.active,
      #workspaces button.focused {
        background: #${base0D};
        color: #${base00};
      }

      #workspaces button.urgent {
        color: #${base08};
        border-bottom-color: #${base08};
      }

      #cpu,
      #memory,
      #pulseaudio,
      #backlight,
      #network,
      #battery,
      #clock {
        color: #${base05};
        padding: 0 12px;
        margin: 5px 0;
      }

      #cpu,
      #memory {
        border-right: 1px solid #${base02};
      }

      #pulseaudio,
      #backlight,
      #network,
      #battery,
      #clock {
        border-left: 1px solid #${base02};
      }

      #battery.warning:not(.charging):not(.plugged) {
        color: #${base0A};
      }

      #battery.critical:not(.charging):not(.plugged) {
        color: #${base08};
        font-weight: bold;
      }

      tooltip {
        background: #${base00};
        border: 1px solid #${base0D};
      }

      tooltip label {
        color: #${base05};
        padding: 4px;
      }
    '';
  };
}
