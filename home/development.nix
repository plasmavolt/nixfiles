{ lib, pkgs, ... }:

{
  home.packages = with pkgs; [
    git
    curl
    unzip
    bun
    nodejs_24
    playwright-driver
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
    ocaml
    ocamlPackages.ocaml-lsp
    ocamlPackages.ocamlformat
    texlive.combined.scheme-medium
  ];

  home.sessionVariables = {
    PKG_CONFIG_PATH = "${pkgs.alsa-lib.dev}/lib/pkgconfig";
    PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
    PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD = "1";
    # lets projects run playwright against any version via launchOptions.executablePath,
    # without pinning their npm playwright to nixpkgs' playwright-driver
    PLAYWRIGHT_CHROMIUM_PATH = "${pkgs.chromium}/bin/chromium";
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
