{ lib, pkgs, ... }:

{
  xdg.configFile."yazi/theme.toml".text = ''
    [icon]
    prepend_dirs = [
      { name = "desktop", text = "\uF108", fg = "#00bcd4" },
      { name = "docs", text = "\uF401", fg = "#00bcd4" },
      { name = "downloads", text = "\uF498", fg = "#00bcd4" },
      { name = "music", text = "\uF025", fg = "#00bcd4" },
      { name = "pics", text = "\uE244", fg = "#00bcd4" },
      { name = "projects", text = "\uE70C", fg = "#00bcd4" },
      { name = "public", text = "\uF42B", fg = "#00bcd4" },
      { name = "vids", text = "\uF447", fg = "#00bcd4" },
    ]
  '';

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
    typst
    tinymist
    typstyle
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
