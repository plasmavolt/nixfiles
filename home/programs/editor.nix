{ config, lib, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # lua config
  xdg.configFile = {
    "nvim/stylix.json".text = builtins.toJSON (
      lib.filterAttrs (
        name: _: builtins.match "base0[0-9A-F]" name != null
      ) config.lib.stylix.colors.withHashtag
    );
    "nvim/init.lua".source = ./nvim/init.lua;
    "nvim/lua".source = ./nvim/lua;
  };
}
