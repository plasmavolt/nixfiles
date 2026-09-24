{ pkgs, ... }:

{
  # locale/time
  time.timeZone = "America/New_York";
  i18n.defaultLocale = "en_US.UTF-8";

  # zram
  zramSwap.enable = true;

  # flakes
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    # If a binary cache (for example Cachix) has a transient 5xx error,
    # build locally instead of failing the whole rebuild.
    fallback = true;
  };

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
