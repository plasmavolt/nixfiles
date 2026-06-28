{ inputs, ... }:

{
  imports = [
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia = {
    enable = true;

    settings = {
      theme = {
        mode = "auto";
        source = "community";
        community_palette = "Kanagawa Dragon";
      };
    };
  };
}
