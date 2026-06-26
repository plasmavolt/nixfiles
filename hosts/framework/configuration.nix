{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest; # latest kernel

  # networking
  networking.hostName = "framework"; # define hostname
  networking.networkmanager.enable = true; # configure network w/ nmtui

  # locale/time
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # user
  users.users.frank = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
    initialPassword = "changeme";
  };

  # audio (pipewire)
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # zram
  zramSwap.enable = true;

  # flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # zsh
  programs.zsh.enable = true;

  # unfree (firmware, etc.)
  nixpkgs.config.allowUnfree = true;

  # wm (niri)
  programs.niri.enable = true;

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

  # x11 compatibility
  programs.xwayland.enable = true;

  # fonts
  fonts.packages = with pkgs; [
    inter-nerdfont
    nerd-fonts.commit-mono
  ];

  # system packages
  environment.systemPackages = with pkgs; [
    wl-clipboard
    xwayland-satellite
    brightnessctl
    cliphist
    nixfmt
    just
    vim
    git
    wget
    gh
  ];

  system.stateVersion = "26.05"; # DO NOT CHANGE

}
