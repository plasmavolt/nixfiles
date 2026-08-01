{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      # build tools
      git
      curl
      unzip
      gcc
      gnumake

      # file browsing
      yazi

      # LSP servers (no mason)
      nixd
      lua-language-server
      basedpyright
      typescript-language-server
      rust-analyzer
      rustc
      cargo
      clang-tools

      # formatters / linters
      nixfmt
      stylua
      ruff
      prettier
      rustfmt

      # lean4
      elan
    ];
  };

  # lua config
  xdg.configFile = {
    "nvim/init.lua".source = ./nvim/init.lua;
    "nvim/lua".source = ./nvim/lua;
  };
}
