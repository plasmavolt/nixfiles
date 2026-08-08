{ lib, ... }:

{
  programs.vesktop = {
    enable = true;

    vencord = {
      useSystem = true;
      themes."system24-auto.theme" = ./vesktop/system24-auto.theme.css;
      settings.enabledThemes = lib.mkAfter [ "system24-auto.theme.css" ];
    };
  };
}
