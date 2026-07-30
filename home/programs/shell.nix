{ pkgs, ... }:

{
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

  # shell packages
  home.packages = with pkgs; [
    ripgrep
    fd
    bat
    fzf
    eza
  ];
}
