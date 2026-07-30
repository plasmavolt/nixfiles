{ ... }:

{
  # app launcher (replaces noctalia's launcher panel)
  # colors/fonts come from stylix's fuzzel target
  programs.fuzzel = {
    enable = true;
    settings.main = {
      terminal = "foot";
      layer = "overlay";
      width = 40;
      lines = 12;
    };
  };
}
