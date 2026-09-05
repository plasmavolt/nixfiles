{ lib, pkgs, ... }:

{
  imports = [
    ./niri
    ./bar.nix
    ./notifs.nix
    ./launcher.nix
    ./wallpaper.nix
  ];

  xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd=${pkgs.xdg-desktop-portal-termfilechooser}/share/xdg-desktop-portal-termfilechooser/yazi-wrapper.sh
    default_dir=$HOME
    env=TERMCMD=${pkgs.foot}/bin/foot -T "Yazi file chooser"
    env=PATH=${
      lib.makeBinPath [
        pkgs.bash
        pkgs.coreutils
        pkgs.gnused
        pkgs.yazi
      ]
    }
    open_mode=suggested
    save_mode=suggested
  '';
}
