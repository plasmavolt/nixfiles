{
  config,
  lib,
  pkgs,
  hostname,
  ...
}:

let
  inherit (config.stylix.fonts) monospace;
  colors = config.lib.stylix.colors;
  inherit (colors)
    base00 # bg
    base03 # muted / borders
    base04 # dim fg
    base0C # aqua
    base0D # blue / accent
    ;

  border = "#${base03}";
  accent = "#${base0D}";
  sep = "text: │ ";

  startPage = pkgs.replaceVars ./files/startpage.html {
    inherit (colors) base00 base05 base0D;
    mono = monospace.name;
    host = "${config.home.username}@${hostname}";
  };

  # 1px borders on Qt chrome
  chromeBorders = pkgs.replaceVars ./files/chrome.py {
    inherit border accent;
  };

  wikipediaRice = pkgs.replaceVars ./files/wikipedia.user.js {
    inherit (colors)
      base00
      base01
      base02
      base03
      base04
      base05
      base06
      base0A
      base0C
      base0D
      ;
    mono = monospace.name;
  };

  zetamacRice = pkgs.replaceVars ./files/zetamac.user.js {
    inherit (colors)
      base00
      base01
      base02
      base03
      base05
      base06
      base08
      base0A
      base0B
      base0C
      base0D
      ;
  };
in
{
  programs.qutebrowser = {
    enable = true;
    settings = {
      scrolling.smooth = true;

      # stylix uses sansSerif + 12pt; statusbar inherits these
      fonts.default_family = lib.mkForce monospace.name;
      fonts.default_size = lib.mkForce "11pt";
      fonts.hints = "10pt ${monospace.name}";

      # tabs as niri windows
      tabs.show = "never";
      tabs.tabs_are_windows = true;

      # statusline
      colors.statusbar.normal.fg = lib.mkForce "#${base04}";
      statusbar.widgets = [
        "keypress"
        "search_match"
        "url"
        sep
        "scroll"
        sep
        "history"
        sep
        "clock:%H:%M"
        "progress"
      ];

      # mode indicators
      colors.statusbar.insert.bg = lib.mkForce "#${base00}";
      colors.statusbar.insert.fg = lib.mkForce accent;
      colors.statusbar.passthrough.bg = lib.mkForce "#${base00}";
      colors.statusbar.passthrough.fg = lib.mkForce "#${base0C}";

      # floating box completion
      completion.height = "30%";
      completion.shrink = true;
      completion.scrollbar.width = 4;
      completion.scrollbar.padding = 1;
      colors.completion.category.border.top = lib.mkForce border;
      colors.completion.category.border.bottom = lib.mkForce border;
      colors.completion.item.selected.border.top = lib.mkForce accent;
      colors.completion.item.selected.border.bottom = lib.mkForce accent;

      # hints float over the page, so alpha is meaningful here (D6 = 84%)
      colors.hints.bg = lib.mkForce "#D6${base00}";

      # start page
      url.start_pages = [ "file://${startPage}" ];
      url.default_page = "file://${startPage}";

      # chrome (window.transparent left off: niri blur under every
      # browser window made tabs-as-windows sluggish)
      downloads.position = "bottom";
      window.title_format = "{perc}{current_title}";
      window.hide_decoration = true;
    };

    # dict-valued settings: HM's `settings` would flatten these into dotted keys
    extraConfig = ''
      c.statusbar.padding = {"top": 4, "bottom": 4, "left": 8, "right": 8}
      c.hints.padding = {"top": 2, "bottom": 2, "left": 4, "right": 4}

      ${builtins.readFile chromeBorders}
    '';
  };

  xdg.dataFile."qutebrowser/greasemonkey/wikipedia.user.js".source = wikipediaRice;
  xdg.dataFile."qutebrowser/greasemonkey/zetamac.user.js".source = zetamacRice;
}
