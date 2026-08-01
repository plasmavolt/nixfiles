{ config, lib, ... }:

let
  inherit (config.stylix.fonts) monospace;
  inherit (config.lib.stylix.colors) base00;

  # translucence as alpha prefix
  translucent = "#E6${base00}";

  uiFontSize = "11pt";

  extraConfig = ''
    c.tabs.padding = {"top": 4, "bottom": 4, "left": 4, "right": 4}
    c.statusbar.padding = {"top": 4, "bottom": 4, "left": 4, "right": 4}
    c.hints.padding = {"top": 2, "bottom": 2, "left": 4, "right": 4}
  '';
in
{
  programs.qutebrowser = {
    enable = true;
    settings = {
      tabs.position = "left";
      scrolling.smooth = true;

      fonts.default_family = lib.mkForce monospace.name;
      fonts.default_size = lib.mkForce uiFontSize;
      fonts.hints = "10pt ${monospace.name}";

      tabs.favicons.scale = 0.8;
      tabs.indicator.width = 0; # disable indicator

      window.transparent = true;
      colors.tabs.bar.bg = lib.mkForce translucent;
      colors.hints.bg = lib.mkForce translucent;
    };

    inherit extraConfig;
  };
}
