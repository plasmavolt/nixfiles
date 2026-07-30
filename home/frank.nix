{ config, ... }:

{
  imports = [
    ./desktop
    ./programs
  ];

  home.username = "frank";
  home.homeDirectory = "/home/frank";
  home.stateVersion = "26.05";

  programs.home-manager.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    documents = "${config.home.homeDirectory}/docs";
    download = "${config.home.homeDirectory}/downloads";
    music = "${config.home.homeDirectory}/music";
    pictures = "${config.home.homeDirectory}/pics";
  };
}
