{ config, pkgs, ... }:

let
  mpdSocket = "${config.xdg.dataHome}/mpd/socket";
  youtubeCache = "${config.xdg.userDirs.music}/.rmpc-youtube";
  # yt updates break older yt-dlp vers
  yt-dlp-latest = pkgs.yt-dlp.overrideAttrs (_: rec {
    version = "2026.08.19";
    src = pkgs.fetchFromGitHub {
      owner = "yt-dlp";
      repo = "yt-dlp";
      tag = version;
      hash = "sha256-BM5ZeGTmHq+1xH6G/zsuCtjLgYgfRA11ya0zIHK5p4g=";
    };
  });
in
{
  home.packages = with pkgs; [
    ffmpeg
    yt-dlp-latest
    (python3.withPackages (pythonPackages: [ pythonPackages.mutagen ]))
  ];

  programs.rmpc = {
    enable = true;
    config = ''
      #![enable(implicit_some)]
      (
        address: "${mpdSocket}",
        cache_dir: "${youtubeCache}",
      )
    '';
  };

  services.mpd = {
    enable = true;
    musicDirectory = config.xdg.userDirs.music;
    network.listenAddress = mpdSocket;
    extraConfig = ''
      auto_update "yes"

      audio_output {
        type "pipewire"
        name "PipeWire"
      }
    '';
  };
}
