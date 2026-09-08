{ config, lib, ... }:

{
  programs.niri.settings = {
    spawn-at-startup = [ { command = [ (lib.getExe config.services.swaync.package) ]; } ];
    # Opt out of the global layer blur: the card is opaque and the transparent
    # padding around it would otherwise show up as a blurred rectangle.
    layer-rules = lib.mkAfter [
      {
        matches = [ { namespace = "^swaync-notification-window$"; } ];
        background-effect.blur = false;
      }
    ];
  };

  systemd.user.services.swaync.Install.WantedBy = lib.mkForce [ ];
  stylix.targets.swaync.enable = false;

  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      layer = "overlay";
      layer-shell = true;
      # Keep the surface content-sized, not a full-height screen strip.
      layer-shell-cover-screen = false;
      notification-window-width = 320;
      notification-window-height = 240;
      image-visibility = "never";
      notification-2fa-action = false;
      notification-inline-replies = false;
      timeout = 4;
      timeout-low = 2;
      timeout-critical = 0;
      transition-time = 120;
      widgets = [ "notifications" ];
      cssPriority = "user";
    };
    style = with config.lib.stylix.colors; ''
      * {
        font-family: "${config.stylix.fonts.monospace.name}";
        font-size: 10pt;
      }

      :root {
        --text-color: #${base05};
        --text-color-disabled: #${base04};
        --bg-selected: #${base0D};
        --border-radius: 10px;
        --font-size-body: 10pt;
        --font-size-summary: 10pt;
      }

      notificationwindow,
      .notification-row,
      .notification-row:focus,
      .notification-row:hover {
        background: transparent;
        box-shadow: none;
      }

      /* SwayNC has no layer-shell margin option for notifications, so this
         padding is the only way to keep the card off the screen edge and bar. */
      .notification-row .notification-background {
        padding: 8px;
      }

      .notification-row .notification-background .notification {
        background: #${base00};
        border: 1px solid #${base03};
        border-radius: 10px;
        box-shadow: none;
        margin: 0;
        padding: 0;
      }

      .notification-row .notification-background .notification.critical {
        border-color: #${base08};
      }

      .notification-row .notification-background .notification .notification-default-action {
        padding: 10px 12px;
        background: transparent;
        border-radius: 10px;
      }

      .notification-row .notification-background .notification .notification-default-action:hover {
        background: alpha(#${base02}, 0.5);
      }

      .notification .summary,
      .notification .body {
        color: #${base05};
      }

      .notification .body {
        margin-top: 4px;
      }

      .notification .time,
      .close-button {
        opacity: 0;
        min-width: 0;
        min-height: 0;
        margin: 0;
        padding: 0;
        font-size: 0;
      }

      .control-center {
        background: #${base00};
        color: #${base05};
      }
    '';
  };
}
