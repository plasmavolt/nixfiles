{ lib, ... }:

{
  programs.obsidian = {
    enable = true;

    vaults."docs/notes" = {
      enable = true;
      settings.appearance = {
        baseFontSize = lib.mkForce 14;
        interfaceFontFamily = lib.mkForce "Iosevka Nerd Font";
        textFontFamily = "Iosevka Nerd Font";
      };
    };

    defaultSettings.app.vimMode = true;
  };
}
