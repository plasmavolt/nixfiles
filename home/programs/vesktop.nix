{ lib, ... }:

{
  programs.vesktop = {
    enable = true;

    vencord = {
      # workaround for discord auto-update
      useSystem = false;
      mutableSettings = true;
      themes."system24-auto.theme" = ./vesktop/system24-auto.theme.css;
      settings.enabledThemes = lib.mkAfter [ "system24-auto.theme.css" ];
    };
  };
}
