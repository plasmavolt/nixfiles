{ inputs, config, ... }:

let
  inherit (config.lib.stylix.colors)
    base00
    base01
    base02
    base03
    base04
    base05
    base06
    base07
    base08
    base09
    base0A
    base0B
    base0C
    base0D
    base0E
    base0F
    ;

  color = value: "#${value}";

  stylixTheme = {
    "$schema" =
      "https://raw.githubusercontent.com/earendil-works/pi/main/packages/coding-agent/src/modes/interactive/theme/theme-schema.json";
    name = "stylix";

    vars = {
      bg = color base00;
      bgAlt = color base01;
      bgSelected = color base02;
      dim = color base03;
      muted = color base04;
      fg = color base05;
      fgAlt = color base06;
      fgBright = color base07;
      red = color base08;
      orange = color base09;
      yellow = color base0A;
      green = color base0B;
      cyan = color base0C;
      blue = color base0D;
      magenta = color base0E;
      brown = color base0F;
    };

    colors = {
      accent = "blue";
      border = "dim";
      borderAccent = "blue";
      borderMuted = "dim";
      success = "green";
      error = "red";
      warning = "yellow";
      muted = "muted";
      dim = "dim";
      text = "fg";
      thinkingText = "muted";

      selectedBg = "bgSelected";
      userMessageBg = "bgAlt";
      userMessageText = "fg";
      customMessageBg = "bgAlt";
      customMessageText = "fg";
      customMessageLabel = "cyan";
      toolPendingBg = "bgAlt";
      toolSuccessBg = "bgAlt";
      toolErrorBg = "bgAlt";
      toolTitle = "blue";
      toolOutput = "fg";

      mdHeading = "yellow";
      mdLink = "blue";
      mdLinkUrl = "muted";
      mdCode = "cyan";
      mdCodeBlock = "fg";
      mdCodeBlockBorder = "dim";
      mdQuote = "muted";
      mdQuoteBorder = "magenta";
      mdHr = "dim";
      mdListBullet = "cyan";

      toolDiffAdded = "green";
      toolDiffRemoved = "red";
      toolDiffContext = "muted";

      syntaxComment = "dim";
      syntaxKeyword = "magenta";
      syntaxFunction = "blue";
      syntaxVariable = "red";
      syntaxString = "green";
      syntaxNumber = "orange";
      syntaxType = "yellow";
      syntaxOperator = "cyan";
      syntaxPunctuation = "fgAlt";

      thinkingOff = "dim";
      thinkingMinimal = "muted";
      thinkingLow = "blue";
      thinkingMedium = "cyan";
      thinkingHigh = "magenta";
      thinkingXhigh = "orange";
      thinkingMax = "red";
      bashMode = "yellow";
    };

    export = {
      pageBg = color base00;
      cardBg = color base01;
      infoBg = color base02;
    };
  };
in
{
  imports = [ inputs.pi.homeModules.default ];

  programs.pi.coding-agent = {
    enable = true;
    environment.PI_CODING_AGENT_DIR.value = "${config.home.homeDirectory}/.pi/agent";
    settings.theme = "stylix";
  };

  home.file.".pi/agent/themes/stylix.json".text = builtins.toJSON stylixTheme;
}
