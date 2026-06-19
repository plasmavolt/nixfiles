{ config, pkgs, ... }:

{
  home.username = "frank";
  home.homeDirectory = "/home/frank";
  home.stateVersion = "26.05";

  # user packages
  home.packages = with pkgs; [
    ripgrep
    fd
    bat
    fzf
    eza
  ];

  programs.git = {
    enable = true;
    settings = {
      user.name = "frank";
      user.email = "screwsareweird@gmail.com";
      init.defaultBranch = "main";
    };
  };

  programs.zsh = {

    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "eza --icons";
      ll = "eza -la --icons";
      cat = "bat";
    };
  };

  # neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  programs.home-manager.enable = true;
}
