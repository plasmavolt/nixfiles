{ pkgs, ... }:

{
  # wm (niri)
  programs.niri.enable = true;
  programs.xwayland.enable = true;

  # audio (pipewire)
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # login manager
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
        user = "greeter";
      };
    };
  };

  # xdg
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    # both gtk.portal and gnome.portal declare UseIn=gnome, so under niri no
    # backend is picked and file dialogs (e.g. obsidian's vault picker) fail.
    config.niri = {
      default = [
        "gnome"
        "gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
    };
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    brightnessctl
    cliphist
    xwayland-satellite
    libnotify
  ];

  # udev rules for brightnessctl
  services.udev.packages = [ pkgs.brightnessctl ];
  users.users.frank.extraGroups = [ "video" ];
}
