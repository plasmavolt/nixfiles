{ inputs, ... }:

{
  imports = [ inputs.osu-lazer.homeManagerModules.osu-lazer ];

  programs.osu-lazer = {
    enable = true;
    nativeWayland = false;
    extraShellArgs = [
      "--set"
      "PIPEWIRE_LATENCY"
      "256/48000"
      "--set"
      "SDL_VIDEO_DOUBLE_BUFFER"
      "1"
    ];
  };
}
