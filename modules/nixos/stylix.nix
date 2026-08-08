{ pkgs, ... }:

{
  stylix.enable = true;
  stylix.image = ./assets/bg2.jpg;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa-dragon.yaml";
  stylix.polarity = "dark";
  stylix.opacity = {
    applications = 0.84;
    desktop = 0.84;
    popups = 0.84;
    terminal = 0.84;
  };
  stylix.fonts = {
    serif = {
      package = pkgs.crimson;
      name = "Crimson";
    };

    sansSerif = {
      package = pkgs.inter;
      name = "Inter";
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
