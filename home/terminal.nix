{ pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "8x8";
      };
    };
  };

  home.packages = with pkgs; [
    foot
  ];
}
