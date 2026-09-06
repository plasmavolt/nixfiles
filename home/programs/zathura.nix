{ config, lib, ... }:

let
  pdfViewer = "org.pwmt.zathura-pdf-mupdf.desktop";
  djvuViewer = "org.pwmt.zathura-djvu.desktop";
  postScriptViewer = "org.pwmt.zathura-ps.desktop";
in
{
  programs.zathura = {
    enable = true;
    options = {
      font = "${config.stylix.fonts.monospace.name} 11";

      adjust-open = "width";
      database = "sqlite";
      guioptions = "s";
      page-h-padding = 8;
      page-v-padding = 8;
      pages-per-row = 1;
      scroll-full-overlap = 0.01;
      scroll-page-aware = true;
      selection-clipboard = "clipboard";
      statusbar-basename = true;
      statusbar-h-padding = 8;
      statusbar-home-tilde = true;
      statusbar-v-padding = 4;
      window-title-basename = true;
      window-title-home-tilde = true;

      recolor = true;
      recolor-darkcolor = lib.mkForce "#${config.lib.stylix.colors.base05}";
      recolor-keephue = true;
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "application/pdf" = pdfViewer;
      "application/epub+zip" = pdfViewer;
      "application/oxps" = pdfViewer;
      "application/x-fictionbook" = pdfViewer;
      "application/x-mobipocket-ebook" = pdfViewer;

      "image/vnd.djvu" = djvuViewer;
      "image/vnd.djvu+multipage" = djvuViewer;

      "application/postscript" = postScriptViewer;
      "application/eps" = postScriptViewer;
      "application/x-eps" = postScriptViewer;
      "image/eps" = postScriptViewer;
      "image/x-eps" = postScriptViewer;
    };
  };
}
