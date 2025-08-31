{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../shared/waybar
  ];

  home.packages = with pkgs; [
    hyprpicker
    grim
    slurp
    wl-clipboard
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false;
    package = pkgs.hyprland;
    portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };

  services.hyprpolkitagent.enable = true;
  services.playerctld.enable = true;

  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";
      general = {
        border_size = 2;
        gaps_in = 2;
        gaps_out = 4;
        "col.active_border" = "rgb(82AAFF)";
        no_focus_fallback = true;
      };
      decoration = {
        blur.enabled = false;
        shadow.enabled = false;
      };
      cursor = {
        no_warps = true;
      };
      input = {
        float_switch_override_focus = 0;
        resolve_binds_by_sym = true;
        follow_mouse = 2;
        accel_profile = "flat";
        repeat_delay = 300;
      };
      dwindle = {
        force_split = 2;
        preserve_split = true;
      };
      misc = {
        vrr = 1;
        focus_on_activate = true;
        new_window_takes_over_fullscreen = true;
        anr_missed_pings = 5;
      };
      xwayland = {
        force_zero_scaling = true;
      };
      bind =
        [
          "$mod, return, exec, uwsm app -- alacritty"
          "$mod, space, exec, uwsm app -- anyrun"
          "$mod, w, killactive,"
          "$mod, o, setfloating,"
          "$mod, y, settiled,"
          "$mod, m, fullscreen, 1"
          "$mod, f, fullscreen, 2"
          "$mod shift, e, exec, uwsm stop"
          ", Print, exec, uwsm app -- grim -g \"$(slurp)\" - | wl-copy"
          "ctrl, Print, exec, uwsm app -- grim - | wl-copy"
          "super, Print, exec, uwsm app -- hyprpicker -a"
        ]
        ++ (builtins.concatLists (
          builtins.genList (
            i: let
              ws = i + 1;
            in [
              "$mod, code:1${toString i}, workspace, ${toString ws}"
              "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
            ]
          )
          10
        ))
        ++ (
          let
            directions = [
              {
                key = "h";
                direction = "l";
              }
              {
                key = "t";
                direction = "d";
              }
              {
                key = "n";
                direction = "u";
              }
              {
                key = "s";
                direction = "r";
              }
            ];
          in
            lib.flatten [
              (map (dir: "$mod, ${dir.key}, movefocus, ${dir.direction}") directions)
              (map (dir: "$mod shift, ${dir.key}, movewindow, ${dir.direction}") directions)
            ]
        )
        ++ [
          ", XF86AudioNext, exec, playerctl next"
          ", XF86AudioPrev, exec, playerctl previous"
          ", XF86AudioPlay, exec, playerctl play-pause"
          ", XF86AudioPause, exec, playerctl play-pause"
        ];
      binde = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ];
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
      animations = {
        enabled = lib.mkDefault false;
      };
      monitor = lib.mkDefault ", preferred, auto, auto";
      exec-once = [
        "swaybg -c 020e1d"
      ];
      exec = [
        "kanshictl reload"
      ];
      workspace = [
        "w[t1], gapsout:0, gapsin:0, bordersize:0"
        "f[1], gapsout:0, gapsin:0, bordersize:0"
      ];
      windowrule = [
        "bordersize 2, floating:1, onworkspace:f[-1]"
        "float, class:^io.github.kaii_lb.Overskride$"
        "float, title:^(File Upload|Open Files)$"
        "noborder, title:Albert"
      ];
    };
  };
}
