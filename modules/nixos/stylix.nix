{ pkgs, ... }:

{
  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/kanagawa-dragon.yaml";
  stylix.fonts = {
    serif = {
      package = pkgs.eb-garamond;
      name = "EB Garamond";
    };

    sansSerif = {
      package = pkgs.inter;
      name = "Inter";
    };

    monospace = {
      package = pkgs.nerd-fonts.commit-mono;
      name = "CommitMono Nerd Font";
    };

    emoji = {
      package = pkgs.twemoji-color-font;
      name = "Twitter Color Emoji";
    };
  };
}
