{ lib, pkgs, ... }:

let
  vimrcSupport = pkgs.runCommand "obsidian-vimrc-support-0.10.2" { } ''
    mkdir "$out"
    cp ${
      pkgs.fetchurl {
        url = "https://github.com/esm7/obsidian-vimrc-support/releases/download/0.10.2/main.js";
        hash = "sha256-aGNzThnu8lBeBUJQyoIbxTL21iceb1AXKx6KBHNObOI=";
      }
    } "$out/main.js"
    cp ${
      pkgs.fetchurl {
        url = "https://github.com/esm7/obsidian-vimrc-support/releases/download/0.10.2/manifest.json";
        hash = "sha256-st5aS+ORuI69konjgVYtFJGlh5ef0Iu9pqf/Ub4n0FY=";
      }
    } "$out/manifest.json"
  '';

  smartTypography = pkgs.runCommand "obsidian-smart-typography-1.0.18" { } ''
    mkdir "$out"
    cp ${
      pkgs.fetchurl {
        url = "https://github.com/mgmeyers/obsidian-smart-typography/releases/download/1.0.18/main.js";
        hash = "sha256-ocaQugyT2+PyA/9uFAELdzcWHjrGzre/liXRl/YgvOQ=";
      }
    } "$out/main.js"
    cp ${
      pkgs.fetchurl {
        url = "https://github.com/mgmeyers/obsidian-smart-typography/releases/download/1.0.18/manifest.json";
        hash = "sha256-6lOk0NpE6xdw002cmrjwpxBG2Lm1wJLsXy0CoOWjVZ8=";
      }
    } "$out/manifest.json"
  '';
in
{
  programs.obsidian = {
    enable = true;

    vaults."docs/notes" = {
      enable = true;
      settings = {
        appearance = {
          baseFontSize = lib.mkForce 14;
          interfaceFontFamily = lib.mkForce "Iosevka Nerd Font";
          textFontFamily = "Iosevka Nerd Font";
        };
        communityPlugins = [
          vimrcSupport
          {
            pkg = smartTypography;
            settings = {
              arrows = false;
              comparisons = false;
              curlyQuotes = false;
              ellipsis = false;
              emDash = true;
              fractions = false;
              guillemets = false;
              skipEnDash = true;
            };
          }
        ];
      };
    };

    defaultSettings.app.vimMode = true;
  };

  home.file."docs/notes/.obsidian.vimrc".text = ''
    nmap j gj
    nmap k gk
  '';
}
