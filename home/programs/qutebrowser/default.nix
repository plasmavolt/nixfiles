{
  config,
  lib,
  pkgs,
  osConfig ? null,
  ...
}:

let
  inherit (config.stylix.fonts) monospace;
  inherit (config.lib.stylix.colors)
    base00 # bg
    base01 # alt bg
    base03 # muted / borders
    base04 # dim fg
    base0C # aqua
    base0B # green
    ;

  # D6 = 214 = 0.84 * 255
  translucent = "#D6${base00}";
  translucentAlt = "#D6${base01}";

  border = "#${base03}";
  accent = "#${base0B}";
  uiFontSize = "11pt";

  sep = "text: │ ";

  quotes = lib.filter (line: line != "" && !lib.hasPrefix "#" line) (
    lib.splitString "\n" (builtins.readFile ./files/quotes.txt)
  );

  startPage = pkgs.replaceVars ./files/startpage.html {
    inherit (config.lib.stylix.colors)
      base00
      base04
      base05
      base0B
      ;
    mono = monospace.name;
    quotes = builtins.toJSON quotes;
    host = "${config.home.username}@${
      if osConfig != null then osConfig.networking.hostName else "nixos"
    }";
  };

  # experimental: 1px borders on Qt chrome
  chromeBorders = pkgs.replaceVars ./files/chrome.py {
    inherit border accent;
  };

  extraConfig = ''
    c.statusbar.padding = {"top": 4, "bottom": 4, "left": 8, "right": 8}
    c.hints.padding = {"top": 2, "bottom": 2, "left": 4, "right": 4}

    ${builtins.readFile chromeBorders}
  '';
in
{
  programs.qutebrowser = {
    enable = true;
    settings = {
      scrolling.smooth = true;

      fonts.default_family = lib.mkForce monospace.name;
      fonts.default_size = lib.mkForce uiFontSize;
      fonts.hints = "10pt ${monospace.name}";

      # Let niri manage browser pages as windows.
      tabs.show = "never";
      tabs.tabs_are_windows = true;

      # statusline
      fonts.statusbar = lib.mkForce "11pt ${monospace.name}";
      colors.statusbar.normal.fg = lib.mkForce "#${base04}";

      # mode indicators
      colors.statusbar.insert.bg = lib.mkForce translucentAlt;
      colors.statusbar.insert.fg = lib.mkForce "#${base0B}";
      colors.statusbar.passthrough.bg = lib.mkForce translucentAlt;
      colors.statusbar.passthrough.fg = lib.mkForce "#${base0C}";
      statusbar.widgets = [
        "keypress"
        "search_match"
        "url"
        sep
        "scroll"
        sep
        "history"
        "text: "
        sep
        "clock:%H:%M"
        "progress"
      ];

      # floating box completion
      completion.height = "30%";
      completion.shrink = true;
      completion.scrollbar.width = 4;
      completion.scrollbar.padding = 1;
      colors.completion.category.border.top = lib.mkForce border;
      colors.completion.category.border.bottom = lib.mkForce border;
      colors.completion.item.selected.border.top = lib.mkForce accent;
      colors.completion.item.selected.border.bottom = lib.mkForce accent;

      # start page
      url.start_pages = [ "file://${startPage}" ];
      url.default_page = "file://${startPage}";

      # chrome
      downloads.position = "bottom";
      window.title_format = "{perc}{current_title}";
      window.hide_decoration = true;
      window.transparent = true;
      colors.hints.bg = lib.mkForce translucent;
    };

    inherit extraConfig;
  };
}
