{ pkgs, ... }:

{
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/gnsfujiwara/base16-mountain-scheme/1a3143f3f0f5bac349b4bfad5cc422dc078e5901/mountain.yaml";
    hash = "sha256-Q2XjbV3PgclhdE9pDwwLX0w9gNAlbfsaCZwO2tCDPo4=";
  }}";
  stylix.polarity = "dark";
  stylix.opacity = {
    applications = 0.92;
    desktop = 0.92;
    popups = 0.92;
    terminal = 0.92;
  };
  stylix.fonts = {
    serif = {
      package = pkgs.crimson;
      name = "Crimson";
    };

    sansSerif = {
      package = pkgs.nerd-fonts.iosevka-term;
      name = "Iosevka Nerd Font";
    };

    monospace = {
      package = pkgs.nerd-fonts.iosevka-term;
      name = "Iosevka Nerd Font";
    };

    emoji = {
      package = pkgs.twemoji-color-font;
      name = "Twitter Color Emoji";
    };
  };
}
