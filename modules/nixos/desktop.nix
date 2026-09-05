{ pkgs, ... }:

{
  hardware.graphics.enable = true;

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
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-termfilechooser
    ];
    # explicitly use gtk and gnome backends
    config.niri = {
      default = [
        "gnome"
        "gtk"
      ];
      "org.freedesktop.impl.portal.FileChooser" = [
        "termfilechooser"
        "gtk"
      ];
    };
  };

  environment.systemPackages = with pkgs; [
    wl-clipboard
    brightnessctl
    cliphist
    xwayland-satellite
    wayland
    libxkbcommon
    libnotify
  ];

  # udev rules for brightnessctl
  services.udev.packages = [ pkgs.brightnessctl ];
  users.users.frank.extraGroups = [ "video" ];
}
