{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ../shared/waybar
  ];

  wayland.windowManager.river = let
    layout = "wideriver";
  in {
    enable = true;
    settings = let
      num_tags = 9;
      all_tags = "$(((1 << ${toString num_tags}) - 1))";
      mod_key = "Super";
    in
      lib.zipAttrs (
        [
          {
            input = {
              accel-profile = "flat";
              "*Touchpad".tap = true;
            };

            rule-add."-app-id".firefox = "ssd";

            map = {
              normal = {
                "${mod_key} Return".spawn = "alacritty";
                "${mod_key} Space".spawn = "anyrun";

                "${mod_key} w" = "close";

                "${mod_key}+Shift q" = "exit";

                "${mod_key} h".focus-view = "left";
                "${mod_key} t".focus-view = "next";
                "${mod_key} n".focus-view = "previous";
                "${mod_key} s".focus-view = "right";

                # resize
                "${mod_key}+Control h".resize = "horizontal -100";
                "${mod_key}+Control t".resize = "vertical +100";
                "${mod_key}+Control n".resize = "vertical -100";
                "${mod_key}+Control s".resize = "horizontal +100";

                "${mod_key}+Shift h".swap = "left";
                "${mod_key}+Shift t".swap = "down";
                "${mod_key}+Shift n".swap = "up";
                "${mod_key}+Shift s".swap = "right";

                "${mod_key} Period".focus-output = "next";
                "${mod_key} Comma".focus-output = "previous";
                "${mod_key}+Shift Period".send-to-output = "next";
                "${mod_key}+Shift Comma".send-to-output = "previous";

                "${mod_key} 0".set-focused-tags = all_tags;
                "${mod_key}+Shift 0".set-view-tags = all_tags;

                "${mod_key} r" = "toggle-float";
                "${mod_key} f" = "toggle-fullscreen";
                "${mod_key} F11".enter-mode = "passthrough";

                "${mod_key} m".send-layout-cmd.${layout} = "'--layout-toggle'";
              };
              passthrough."${mod_key} F11".enter-mode = "normal";
            };

            # map.normal."${mod_key} Up".send-layout-cmd.${layout} = "'main-location top'";
            # map.normal."${mod_key} Left".send-layout-cmd.${layout} = "'main-location left'";
            # map.normal."${mod_key} Down".send-layout-cmd.${layout} = "'main-location bottom'";
            # map.normal."${mod_key} Right".send-layout-cmd.${layout} = "'main-location right'";

            # map.normal."${mod_key} h".send-layout-cmd.${layout} = "'main-ratio -0.05'";
            # map.normal."${mod_key} l".send-layout-cmd.${layout} = "'main-ratio +0.05'";
            # map.normal."${mod_key} i".send-layout-cmd.${layout} = "'main-count +1'";
            # map.normal."${mod_key} d".send-layout-cmd.${layout} = "'main-count -1'";

            map-pointer.normal = {
              "${mod_key} BTN_LEFT" = "move-view";
              "${mod_key} BTN_RIGHT" = "resize-view";
              "${mod_key} BTN_MIDDLE" = "toggle-float";
            };

            declare-mode = "passthrough";

            # input."'*Touchpad'".tap = "enabled";
            set-repeat = "50 300";

            default-layout = layout;
          }
        ]
        ++ (map (
          index: let
            i = toString index;
            tags = "$((1 << (${i} - 1)))";
          in {
            map.normal."${mod_key} ${i}".set-focused-tags = tags;
            map.normal."${mod_key}+Shift ${i}".set-view-tags = tags;
            map.normal."${mod_key}+Control ${i}".toggle-focused-tags = tags;
            map.normal."${mod_key}+Shift+Control ${i}".toggle-view-tags = tags;
          }
        ) (lib.range 1 num_tags))
      );
    extraConfig = ''
      ${layout} --layout left --inner-gaps 4 --outer-gaps 4 --smart-gaps &
    '';
  };

  home.packages = with pkgs; [
    wideriver
    hyprpicker
    grim
    slurp
    wl-clipboard
  ];
}
