{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    curl
    unzip
    gcc
    gnumake
    pkg-config
    alsa-lib
    yazi
    nixd
    lua-language-server
    basedpyright
    typescript-language-server
    rust-analyzer
    rustc
    cargo
    clang-tools
    nixfmt
    stylua
    ruff
    prettier
    rustfmt
    elan
  ];

  home.sessionVariables = {
    PKG_CONFIG_PATH = "${pkgs.alsa-lib.dev}/lib/pkgconfig";
    LD_LIBRARY_PATH = "${
      lib.makeLibraryPath [
        pkgs.wayland
        pkgs.libxkbcommon
        pkgs.vulkan-loader
        pkgs.libglvnd
        pkgs.mesa
      ]
    }:/run/opengl-driver/lib";
  };
}
