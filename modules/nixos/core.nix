{ pkgs, ... }:

{
  # locale/time
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # zram
  zramSwap.enable = true;

  # flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # zsh
  programs.zsh.enable = true;

  # unfree
  nixpkgs.config.allowUnfree = true;

  # system packages
  environment.systemPackages = with pkgs; [
    nixfmt
    just
    vim
    git
    wget
    gh
  ];
}
