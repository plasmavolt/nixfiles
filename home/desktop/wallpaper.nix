{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.awww.enable = true;

  systemd.user.services.awww = {
    Unit = {
      After = lib.mkForce [ "niri.service" ];
      PartOf = lib.mkForce [ "niri.service" ];
    };
    Install.WantedBy = lib.mkForce [ "niri.service" ];
  };

  home.packages = [ pkgs.waypaper ];

  # wallpapers are managed mutably
  home.activation.createWallpaperDirectory = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD mkdir -p ${lib.escapeShellArg "${config.xdg.userDirs.pictures}/walls"}
  '';

  xdg.configFile."waypaper/config.ini".text = ''
    [Settings]
    backend = awww
    folder = ${config.xdg.userDirs.pictures}/walls
    fill = fill
    sort = name
    subfolders = False
    all_subfolders = False
    use_xdg_state = True
    monitors = All
    swww_transition_type = fade
    swww_transition_duration = 1
    swww_transition_fps = 60
  '';

  systemd.user.services.waypaper-restore = {
    Unit = {
      Description = "Restore the Waypaper wallpaper";
      After = [ "awww.service" ];
      Requires = [ "awww.service" ];
      PartOf = [ "niri.service" ];
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${lib.getExe pkgs.waypaper} --restore";
    };

    Install.WantedBy = [ "niri.service" ];
  };
}
