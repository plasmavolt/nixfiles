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

  programs.fish = {

    enable = true;

    shellAliases = {
      ls = "eza --icons";
      ll = "eza -la --icons";
      cat = "bat";
    };

    plugins = [
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "forgit";
        src = pkgs.fishPlugins.forgit.src;
      }
      {
        name = "pure";
        src = pkgs.fishPlugins.pure.src;
      }
      {
        name = "grc";
        src = pkgs.fishPlugins.grc.src;
      }
    ];
  };

  # shell packages
  home.packages = with pkgs; [
    ripgrep
    fd
    jq
    bat
    fzf
    eza
    zoxide
    grc
  ];
}
