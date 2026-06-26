{ pkgs, ... }:
{
  users.users.frank = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ];
    shell = pkgs.zsh;
    initialPassword = "changeme";
  };
}
