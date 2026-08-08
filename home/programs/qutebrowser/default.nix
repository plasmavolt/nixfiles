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
    base0A # yellow
    base0B # green
    ;

  # D6 = 214 = 0.84 * 255
  translucent = "#D6${base00}";
  translucentAlt = "#D6${base01}";

  border = "#${base03}";
  accent = "#${base0B}";
  selected = "#D6${base0A}";

  uiFontSize = "11pt";

  tabPosition = "left";
  tabEdge =
    {
      left = "border-right";
      right = "border-left";
      top = "border-bottom";
      bottom = "border-top";
    }
    .${tabPosition};

  sep = "text: │ ";

  # links on start page + quicklinks
  links = {
    dev = {
      github = "https://github.com";
      nixpkgs = "https://github.com/NixOS/nixpkgs";
      noogle = "https://noogle.dev";
    };
    read = {
      wikipedia = "https://wikipedia.org";
      lobsters = "https://lobste.rs";
      hackernews = "https://news.ycombinator.com";
    };
    media = {
      youtube = "https://youtube.com";
      substack = "https://substack.com";
      reddit = "https://reddit.com";
    };
  };

  mkEntry = name: url: ''<li><span class="idx">-</span> <a href="${url}">${name}</a></li>'';

  mkSection = category: entries: ''
    <fieldset class="box">
      <legend>${category}</legend>
      <ul>
    ${lib.concatStringsSep "\n" (lib.mapAttrsToList mkEntry entries)}
      </ul>
    </fieldset>'';

  startPage = pkgs.replaceVars ./files/startpage.html {
    inherit (config.lib.stylix.colors)
      base00
      base03
      base04
      base05
      base0B
      base0D
      ;
    mono = monospace.name;
    host = "${config.home.username}@${
      if osConfig != null then osConfig.networking.hostName else "nixos"
    }";
    sections = lib.concatStringsSep "\n" (lib.mapAttrsToList mkSection links);
  };

  # experimental: 1px borders on Qt chrome
  chromeBorders = pkgs.replaceVars ./files/chrome.py {
    inherit border accent tabEdge;
  };

  extraConfig = ''
    c.tabs.padding = {"top": 4, "bottom": 4, "left": 8, "right": 6}
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

      # sidebar tabs
      tabs.position = tabPosition;
      tabs.favicons.show = "never";
      tabs.indicator.width = 0; # disable indicator
      tabs.title.format = "{audio}{index} │ {current_title}";
      tabs.title.format_pinned = "{index} ";

      # focused tab
      colors.tabs.selected.even.bg = lib.mkForce selected;
      colors.tabs.selected.odd.bg = lib.mkForce selected;
      colors.tabs.selected.even.fg = lib.mkForce "#${base00}";
      colors.tabs.selected.odd.fg = lib.mkForce "#${base00}";
      colors.tabs.pinned.selected.even.bg = lib.mkForce selected;
      colors.tabs.pinned.selected.odd.bg = lib.mkForce selected;
      colors.tabs.pinned.selected.even.fg = lib.mkForce "#${base00}";
      colors.tabs.pinned.selected.odd.fg = lib.mkForce "#${base00}";

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
        "tabs"
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
      colors.tabs.bar.bg = lib.mkForce translucent;
      colors.hints.bg = lib.mkForce translucent;
    };

    quickmarks = lib.foldl' (acc: c: acc // c) { } (lib.attrValues links);

    inherit extraConfig;
  };
}
