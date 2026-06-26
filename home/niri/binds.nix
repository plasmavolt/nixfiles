{ ... }:

{
  programs.niri.settings.binds = {
    # core
    "Mod+Shift+Slash".action.show-hotkey-overlay = { };
    "Mod+Q".action.close-window = { };
    "Mod+Shift+E".action.quit = { };

    # window
    "Mod+H".action.focus-column-left = { };
    "Mod+J".action.focus-window-down = { };
    "Mod+K".action.focus-window-up = { };
    "Mod+L".action.focus-column-right = { };

    "Mod+Shift+H".action.move-column-left = { };
    "Mod+Shift+J".action.move-window-down = { };
    "Mod+Shift+K".action.move-window-up = { };
    "Mod+Shift+L".action.move-column-right = { };

    "Mod+R".action.switch-preset-column-width = { };
    "Mod+Shift+R".action.reset-window-height = { };
    "Mod+C".action.center-column = { };
    "Mod+F".action.maximize-column = { };
    "Mod+Shift+F".action.fullscreen-window = { };

    "Mod+Comma".action.consume-window-into-column = { };
    "Mod+Period".action.expel-window-from-column = { };
    "Mod+BracketLeft".action.consume-or-expel-window-left = { };
    "Mod+BracketRight".action.consume-or-expel-window-right = { };

    "Mod+Minus".action.set-column-width = "-10%";
    "Mod+Equal".action.set-column-width = "+10%";
    "Mod+Shift+Minus".action.set-window-height = "-10%";
    "Mod+Shift+Equal".action.set-window-height = "+10%";

    "Mod+Shift+V".action.toggle-window-floating = { };
    "Mod+V".action.switch-focus-between-floating-and-tiling = { };

    # workspace
    "Mod+U".action.focus-workspace-down = { };
    "Mod+I".action.focus-workspace-up = { };
    "Mod+Shift+U".action.move-column-to-workspace-down = { };
    "Mod+Shift+I".action.move-column-to-workspace-up = { };

    "Mod+1".action.focus-workspace = 1;
    "Mod+2".action.focus-workspace = 2;
    "Mod+3".action.focus-workspace = 3;
    "Mod+4".action.focus-workspace = 4;
    "Mod+5".action.focus-workspace = 5;
    "Mod+6".action.focus-workspace = 6;
    "Mod+7".action.focus-workspace = 7;
    "Mod+8".action.focus-workspace = 8;
    "Mod+9".action.focus-workspace = 9;
    "Mod+0".action.focus-workspace = 10;
    "Mod+Ctrl+1".action.move-column-to-workspace = 1;
    "Mod+Ctrl+2".action.move-column-to-workspace = 2;
    "Mod+Ctrl+3".action.move-column-to-workspace = 3;
    "Mod+Ctrl+4".action.move-column-to-workspace = 4;
    "Mod+Ctrl+5".action.move-column-to-workspace = 5;
    "Mod+Ctrl+6".action.move-column-to-workspace = 6;
    "Mod+Ctrl+7".action.move-column-to-workspace = 7;
    "Mod+Ctrl+8".action.move-column-to-workspace = 8;
    "Mod+Ctrl+9".action.move-column-to-workspace = 9;
    "Mod+Ctrl+0".action.move-column-to-workspace = 10;

    # overview
    "Mod+Slash".action.toggle-overview = { };

    # spawn
    "Mod+Return".action.spawn = "foot";
    "Mod+Space".action.spawn = "fuzzel";

    # audio
    "XF86AudioRaiseVolume" = {
      allow-when-locked = true;
      action.spawn = [
        "wpctl"
        "set-volume"
        "@DEFAULT_AUDIO_SINK@"
        "0.1+"
      ];
    };
    "XF86AudioLowerVolume" = {
      allow-when-locked = true;
      action.spawn = [
        "wpctl"
        "set-volume"
        "@DEFAULT_AUDIO_SINK@"
        "0.1-"
      ];
    };
    "XF86AudioMute" = {
      allow-when-locked = true;
      action.spawn = [
        "wpctl"
        "set-mute"
        "@DEFAULT_AUDIO_SINK@"
        "toggle"
      ];
    };
    "XF86AudioMicMute" = {
      allow-when-locked = true;
      action.spawn = [
        "wpctl"
        "set-mute"
        "@DEFAULT_AUDIO_SOURCE@"
        "toggle"
      ];
    };

  };
}
