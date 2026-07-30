{ pkgs, ... }:

{
  programs.swaylock = {
    enable = true;
    settings = {
      ignore-empty-password = true;
      show-failed-attempts = true;
      indicator-caps-lock = true;
      clock = true;
    };
  };

  # idle handling
  services.swayidle = {
    enable = true;
    events = {
      before-sleep = "${pkgs.swaylock}/bin/swaylock -f";
      lock = "${pkgs.swaylock}/bin/swaylock -f";
    };
    timeouts = [
      {
        timeout = 300;
        command = "${pkgs.swaylock}/bin/swaylock -f";
      }
      {
        timeout = 600;
        command = "niri msg action power-off-monitors";
        resumeCommand = "niri msg action power-on-monitors";
      }
    ];
  };

  programs.niri.settings.binds = {
    "Mod+Escape" = {
      allow-when-locked = true;
      action.spawn = "swaylock";
    };
  };
}
