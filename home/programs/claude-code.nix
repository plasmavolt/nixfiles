{ config, pkgs, ... }:

let
  colors = config.lib.stylix.colors;

  # Claude Code custom theme (~/.claude/themes/<slug>.json, selected as
  # `custom:<slug>`). Overrides must be keys of the base theme's palette.
  channel = name: c: builtins.fromJSON colors."${name}-rgb-${c}";
  rgb =
    r: g: b:
    "rgb(${toString r},${toString g},${toString b})";
  c = name: rgb (channel name "r") (channel name "g") (channel name "b");
  # `pct` percent of `b` over `a`; used for tinted backgrounds and shimmers.
  mix =
    a: b: pct:
    let
      ch = x: (channel a x * (100 - pct) + channel b x * pct) / 100;
    in
    rgb (ch "r") (ch "g") (ch "b");
  shimmer = name: mix name "base07" 35;

  claudeTheme = {
    name = "Stylix";
    base = if config.stylix.polarity == "light" then "light" else "dark";
    overrides = {
      text = c "base05";
      inverseText = c "base00";
      inactive = mix "base03" "base05" 60;
      inactiveShimmer = mix "base03" "base05" 85;
      subtle = mix "base03" "base05" 25;
      promptBorder = mix "base03" "base05" 30;
      promptBorderShimmer = mix "base03" "base05" 60;

      claude = c "base09";
      claudeShimmer = shimmer "base09";
      clawd_body = c "base09";
      clawd_background = c "base00";
      briefLabelClaude = c "base09";
      briefLabelYou = c "base0D";
      claudeBlue_FOR_SYSTEM_SPINNER = c "base0D";
      claudeBlueShimmer_FOR_SYSTEM_SPINNER = shimmer "base0D";

      permission = c "base0D";
      permissionShimmer = shimmer "base0D";
      suggestion = c "base0D";
      remember = c "base0D";
      ide = c "base0D";
      professionalBlue = c "base0D";
      planMode = c "base0C";
      background = c "base0C";
      autoAccept = c "base0E";
      autoAcceptShimmer = shimmer "base0E";
      skill = c "base0E";
      merged = c "base0E";
      effortUltra = c "base0E";
      bashBorder = c "base08";
      fastMode = c "base09";
      fastModeShimmer = shimmer "base09";
      chromeYellow = c "base0A";

      success = c "base0B";
      error = c "base08";
      warning = c "base0A";
      warningShimmer = shimmer "base0A";

      # Diff lines are drawn as backgrounds under base05 text, so tint base00
      # rather than using the (pastel) accent colors directly.
      diffAdded = mix "base00" "base0B" 30;
      diffRemoved = mix "base00" "base08" 30;
      diffAddedDimmed = mix "base00" "base0B" 15;
      diffRemovedDimmed = mix "base00" "base08" 15;
      diffAddedWord = mix "base00" "base0B" 55;
      diffRemovedWord = mix "base00" "base08" 55;

      userMessageBackground = c "base01";
      userMessageBackgroundHover = c "base02";
      composerSidebarBackground = mix "base00" "base01" 50;
      selectionBg = mix "base00" "base0D" 40;
      bashMessageBackgroundColor = mix "base00" "base08" 15;
      memoryBackgroundColor = mix "base00" "base0C" 15;
      rate_limit_fill = c "base0D";
      rate_limit_empty = c "base03";

      red_FOR_SUBAGENTS_ONLY = c "base08";
      orange_FOR_SUBAGENTS_ONLY = c "base09";
      yellow_FOR_SUBAGENTS_ONLY = c "base0A";
      green_FOR_SUBAGENTS_ONLY = c "base0B";
      cyan_FOR_SUBAGENTS_ONLY = c "base0C";
      blue_FOR_SUBAGENTS_ONLY = c "base0D";
      purple_FOR_SUBAGENTS_ONLY = c "base0E";
      pink_FOR_SUBAGENTS_ONLY = mix "base08" "base0E" 50;
    };
  };

  # Reads the session JSON Claude Code pipes to the status line command on stdin.
  # Colors are plain ANSI so they follow the Stylix-themed terminal palette.
  statusline = pkgs.writeShellApplication {
    name = "claude-statusline";
    runtimeInputs = [
      pkgs.jq
      pkgs.git
    ];
    text = ''
      input=$(cat)

      IFS=$'\x1f' read -r model dir pct used size tin tout cost dur added removed < <(
        jq -r '
          def human: if . >= 1000000 then "\(. / 1000000 * 10 | floor / 10)M"
                     elif . >= 1000 then "\(. / 1000 | floor)k"
                     else tostring end;
          (.context_window // {}) as $c
          | ($c.current_usage // {}) as $u
          | (($u.input_tokens // 0) + ($u.cache_creation_input_tokens // 0)
             + ($u.cache_read_input_tokens // 0)) as $ctx
          | ($c.context_window_size // 200000) as $size
          | [ .model.display_name // "?",
              .workspace.current_dir // .cwd // "",
              ($c.used_percentage // ($ctx * 100 / $size) | floor),
              ($ctx | human),
              ($size | human),
              ($c.total_input_tokens // 0 | human),
              ($c.total_output_tokens // 0 | human),
              (.cost.total_cost_usd // 0 | . * 100 | round / 100),
              ((.cost.total_duration_ms // 0) / 60000 | floor),
              .cost.total_lines_added // 0,
              .cost.total_lines_removed // 0
            ] | map(tostring) | join("\u001f")' <<<"$input"
      )

      if ((pct >= 80)); then pc=31; elif ((pct >= 50)); then pc=33; else pc=32; fi
      sep=$'\e[90m │ \e[0m'

      out=$'\e[35m'"$model"$'\e[0m'
      out+="$sep"$'\e['"$pc"'m'"ctx $pct%"$'\e[0m'" $used/$size"
      out+="$sep"$'\e[36m'"in $tin"$'\e[0m'" · "$'\e[34m'"out $tout"$'\e[0m'
      out+="$sep"$'\e[33m'"\$$(printf '%.2f' "$cost")"$'\e[0m'
      out+="$sep''${dur}m"
      out+="$sep"$'\e[32m'"+$added"$'\e[0m'" "$'\e[31m'"-$removed"$'\e[0m'

      if branch=$(git -C "$dir" branch --show-current 2>/dev/null) && [[ -n $branch ]]; then
        dirty=$(git -C "$dir" status --porcelain 2>/dev/null | head -c1)
        out+="$sep"$'\e[34m'"⎇ $branch''${dirty:+*}"$'\e[0m'
      fi

      printf '%s\n' "$out"
    '';
  };
in
{
  home.packages = [
    pkgs.claude-code
    statusline
  ];

  home.file.".claude/themes/stylix.json".text = builtins.toJSON claudeTheme;
}
