{ pkgs, ... }:

let
  yaziFileChooser = pkgs.writeShellScript "yazi-file-chooser" ''
    multiple="$1"
    directory="$2"
    save="$3"
    path="$4"
    out="$5"

    if [ "$save" = 1 ]; then
      set -- --chooser-file="$out" "$path"
    elif [ "$directory" = 1 ]; then
      set -- --chooser-file="$out" --cwd-file="$out.1" "$path"
    elif [ "$multiple" = 1 ]; then
      set -- --chooser-file="$out" "$path"
    else
      set -- --chooser-file="$out" "$path"
    fi

    ${pkgs.foot}/bin/foot --app-id=yazi-file-chooser --override=colors-dark.alpha=1.0 -T "Yazi file chooser" ${pkgs.yazi}/bin/yazi "$@"

    if [ "$directory" = 1 ]; then
      if [ ! -s "$out" ] && [ -s "$out.1" ]; then
        ${pkgs.coreutils}/bin/cat "$out.1" > "$out"
      fi
      ${pkgs.coreutils}/bin/rm -f "$out.1"
    fi
  '';
in
{
  imports = [
    ./niri
    ./bar.nix
    ./notifs.nix
    ./launcher.nix
    ./wallpaper.nix
  ];

  # automount
  services.udiskie = {
    enable = true;
    # annoying ass bug: build kernel returns `EKEYREVOKED` but udiskie 2.7.0 expects `ENOKEY`
    package = pkgs.udiskie.overridePythonAttrs (old: {
      pytestFlags = (old.pytestFlags or [ ]) ++ [
        "--deselect=test/test_keyutils.py::TestKeyutils::test_invalidate"
      ];
    });
    automount = true;
    notify = true;
    tray = "never";
  };

  xdg.configFile."xdg-desktop-portal-termfilechooser/config".text = ''
    [filechooser]
    cmd=${yaziFileChooser}
    default_dir=$HOME
    open_mode=suggested
    save_mode=suggested
  '';
}
