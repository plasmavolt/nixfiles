{ config, pkgs, ... }:

let
  colors = config.lib.stylix.colors;
  accent = text: "<span color='#${colors.base0D}'>${text}</span>";

  # replacement for waybar network module
  netSpeed = pkgs.writeShellScript "waybar-net-speed" ''
    interval=2
    human() {
      awk -v b="$1" 'BEGIN {
        k = b / 1024; m = k / 1024
        if (m >= 100) printf "%4dM", m
        else if (m >= 1) printf "%4.1fM", m
        else if (k >= 100) printf "%4dk", k
        else printf "%4.1fk", k
      }'
    }
    counters() {
      awk -v i="$1" '$1 == i ":" { print $2, $10 }' /proc/net/dev
    }
    while true; do
      iface=$(${pkgs.iproute2}/bin/ip -o route show default | awk '{ print $5; exit }')
      if [ -z "$iface" ]; then
        printf '{"text":"NET OFF","class":"disconnected","tooltip":"Disconnected"}\n'
        sleep "$interval"
        continue
      fi
      set -- $(counters "$iface")
      rx0=$1 tx0=$2
      sleep "$interval"
      set -- $(counters "$iface")
      rx=$(( ($1 - rx0) / interval ))
      tx=$(( ($2 - tx0) / interval ))
      if [ -d "/sys/class/net/$iface/wireless" ]; then label=WLAN; else label=LAN; fi
      printf '{"text":"%s \u2193<span color=\\"#%s\\">%s</span> \u2191<span color=\\"#%s\\">%s</span>","tooltip":"%s"}\n' \
        "$label" "${colors.base0D}" "$(human "$rx")" "${colors.base0D}" "$(human "$tx")" "$iface"
    done
  '';
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
        "custom/net"
        "pulseaudio"
        "backlight"
        "battery"
        "clock"
      ];

      "niri/workspaces" = {
        format = "{icon}";
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

      "custom/net" = {
        exec = "${netSpeed}";
        return-type = "json";
        markup = true;
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
        format-warning = "BAT {capacity:02}%";
        format-critical = "BAT {capacity:02}%";
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
      #custom-net,
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
      #custom-net,
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
