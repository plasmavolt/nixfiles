{ pkgs, ... }:

{
  fonts = {
    packages = with pkgs; [
      # normal fonts
      inter
      eb-garamond
      source-han-sans
      source-han-serif

      # nerdfonts
      nerd-fonts.symbols-only
      nerd-fonts.jetbrains-mono
      nerd-fonts.iosevka
      nerd-fonts.commit-mono

      twemoji-color-font # emoji
    ];

    enableDefaultPackages = false;

    # fontconfig = {
    #   enable = true;
    #   defaultFonts = {
    #     serif = [
    #       "EB Garamond"
    #       "Source Han Serif"
    #       "Twitter Color Emoji"
    #     ];
    #     sansSerif = [
    #       "Inter"
    #       "Source Han Sans"
    #       "Twitter Color Emoji"
    #     ];
    #     monospace = [
    #       "CommitMono Nerd Font"
    #       "Twitter Color Emoji"
    #     ];
    #     emoji = [ "Twitter Color Emoji" ];
    #   };
    # };
  };
}
