{ config, pkgs, ... }:

{
  programs.foot = {
    enable = true;
    settings = {
      main = {
        pad = "8x8";
        shell = "${pkgs.fish}/bin/fish";
      };
    };
  };

  programs.niri.settings.spawn-at-startup = [
    {
      command = [
        "${config.programs.foot.package}/bin/foot"
        "--server"
      ];
    }
  ];
}
