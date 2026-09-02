{ ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # lua config
  xdg.configFile = {
    "nvim/init.lua".source = ./nvim/init.lua;
    "nvim/lua".source = ./nvim/lua;
  };
}
