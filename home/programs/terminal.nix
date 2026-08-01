{ pkgs, ... }:

{
  stylix.opacity.terminal = 0.9;

  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "8x8";
        shell = "${pkgs.fish}/bin/fish";
      };
    };
  };
}
