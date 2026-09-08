{ config, lib, ... }:

let
  colors = config.lib.stylix.colors;
  opacity = lib.toHexString (builtins.ceil (config.stylix.opacity.popups * 255));
in
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        terminal = "footclient";
        layer = "overlay";
        font = lib.mkForce "${config.stylix.fonts.monospace.name}:size=11";

        anchor = "top-left";
        x-margin = 8;
        y-margin = 8;
        width = 44;
        lines = 8;
        line-height = 22;
        horizontal-pad = 18;
        vertical-pad = 12;
        inner-pad = 8;

        prompt = "'›  '";
        placeholder = "run";
        icons-enabled = false;
        show-actions = false;
        filter-desktop = true;
        match-mode = "fzf";
        list-executables-in-path = false;
      };

      border = {
        width = 1;
        radius = 10;
        selection-radius = 6;
      };

      colors = with colors; {
        background = lib.mkForce "${base00-hex}${opacity}";
        border = lib.mkForce "${base03-hex}80";
        prompt = lib.mkForce "${base03-hex}ff";
        placeholder = lib.mkForce "${base03-hex}ff";
        input = lib.mkForce "${base06-hex}ff";
        text = lib.mkForce "${base05-hex}ff";
        match = lib.mkForce "${base0D-hex}ff";
        selection = lib.mkForce "${base01-hex}ff";
        selection-text = lib.mkForce "${base06-hex}ff";
        selection-match = lib.mkForce "${base0D-hex}ff";
        counter = lib.mkForce "${base03-hex}ff";
      };
    };
  };

  programs.niri.settings.layer-rules = lib.mkAfter [
    {
      matches = [ { namespace = "^launcher$"; } ];
      geometry-corner-radius = {
        top-left = 10.0;
        top-right = 10.0;
        bottom-left = 10.0;
        bottom-right = 10.0;
      };
      background-effect = {
        blur = true;
        xray = false;
      };
    }
  ];
}
