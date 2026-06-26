{ pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        font = "monospace:size=12";
        pad = "8x8";
      };
    };
  };

  home.packages = with pkgs; [
    foot
  ];
}
