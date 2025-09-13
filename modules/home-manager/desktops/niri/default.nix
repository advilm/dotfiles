{
  lib,
  self,
  pkgs,
  ...
}: let
  inherit (lib) getExe;

  alacritty = pkgs.writeShellScript "spawn-alacritty" ''
    if pgrep -x alacritty >/dev/null; then
        alacritty msg create-window
    else
        uwsm app -- alacritty
    fi
  '';

  notify-call = getExe self.packages.${pkgs.system}.notify-call;

  changeBrightness = pkgs.writeShellScript "change-brightness" ''
    if [ "$1" = "up" ]; then
      brightnessctl set +5%
    elif [ "$1" = "down" ]; then
      brightnessctl set 5%-
    fi
    brightness="$(brightnessctl -m | cut -d, -f4 | tr -d %)"
    ${notify-call} -i display-brightness-symbolic -R brightness --hint int:value:"$brightness" -t 2000 ""
  '';

  changeVolume = pkgs.writeShellScript "change-volume" ''
    if [ "$1" = "up" ]; then
      wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+
    elif [ "$1" = "down" ]; then
      wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-
    elif [ "$1" = "mute" ]; then
      wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    fi
    volume="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2*100}')"
    muted="$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | cut -d' ' -f3)"
    if [ -n "$muted" ] || [ "$volume" -eq 0 ]; then
      ${notify-call} -i audio-volume-muted-symbolic -R volume --hint int:value:"$volume" -t 2000 ""
    else
      level=""
      if [ "$volume" -ge 67 ]; then
        level="high"
      elif [ "$volume" -ge 34 ]; then
        level="medium"
      else
        level="low"
      fi

      ${notify-call} -i audio-volume-$level-symbolic -R volume --hint int:value:"$volume" -t 2000 ""
    fi
  '';
in {
  imports = [../shared/waybar];
  xdg.configFile."niri/config.kdl".text = ''
    prefer-no-csd
    input {
        keyboard {
            repeat-delay 300
            repeat-rate 25
        }
        touchpad {
            tap
            dwt
            accel-profile "flat"
            scroll-factor 0.7
        }
        mouse {
            accel-profile "flat"
        }
    }
    layout {
        gaps 4
        background-color "#020e1d"
        default-column-width {
            proportion 0.5
        }
        preset-column-widths {
            proportion 0.66667
            proportion 0.33333
            proportion 0.5
        }
        border {
            width 2
            active-color "#82AAFF"
        }
        focus-ring {
            off
        }
    }
    animations {
        slowdown 0.80
        workspace-switch {
            off
        }
        window-open {
            off
        }
        window-close {
            off
        }
    }
    hotkey-overlay {
        skip-at-startup
    }
    screenshot-path "~/screenshots/%Y-%m-%d_%H-%M-%S.png"
    workspace "1"
    workspace "2"
    workspace "3"
    workspace "4"
    binds {
        Mod+Return repeat=false { spawn "${alacritty}"; }
        Mod+Space repeat=false { spawn "uwsm" "app" "--" "anyrun"; }
        Mod+W repeat=false { close-window; }

        Mod+Shift+E { quit skip-confirmation=true; }
        Mod+O repeat=false { toggle-overview; }

        Mod+V repeat=false { toggle-window-floating; }
        Mod+Shift+V repeat=false { switch-focus-between-floating-and-tiling; }
        Mod+F repeat=false { fullscreen-window; }
        Mod+M repeat=false { maximize-column; }
        Mod+R repeat=false { switch-preset-column-width; }
        Mod+Shift+R repeat=false { expand-column-to-available-width; }
        Mod+Y repeat=false { toggle-column-tabbed-display; }
        Mod+Comma repeat=false { consume-or-expel-window-left; }
        Mod+Period repeat=false { consume-or-expel-window-right; }
        Mod+C repeat=false { center-column; }
        Mod+Escape allow-inhibiting=false { toggle-keyboard-shortcuts-inhibit; }

        Mod+Left { focus-column-left; }
        Mod+Down { focus-window-down; }
        Mod+Up { focus-window-up; }
        Mod+Right { focus-column-right; }
        Mod+H { focus-column-left; }
        Mod+T { focus-window-down; }
        Mod+N { focus-window-up; }
        Mod+S { focus-column-right; }

        Mod+Shift+Left { move-column-left; }
        Mod+Shift+Down { move-window-down; }
        Mod+Shift+Up { move-window-up; }
        Mod+Shift+Right { move-column-right; }
        Mod+Shift+H { move-column-left; }
        Mod+Shift+T { move-window-down; }
        Mod+Shift+N { move-window-up; }
        Mod+Shift+S { move-column-right; }

        Mod+1 { focus-workspace "1"; }
        Mod+2 { focus-workspace "2"; }
        Mod+3 { focus-workspace "3"; }
        Mod+4 { focus-workspace "4"; }
        Mod+5 { focus-workspace 5; }
        Mod+6 { focus-workspace 6; }
        Mod+7 { focus-workspace 7; }
        Mod+8 { focus-workspace 8; }
        Mod+9 { focus-workspace 9; }
        Mod+Shift+1 { move-column-to-workspace focus=false "1"; }
        Mod+Shift+2 { move-column-to-workspace focus=false "2"; }
        Mod+Shift+3 { move-column-to-workspace focus=false "3"; }
        Mod+Shift+4 { move-column-to-workspace focus=false "4"; }
        Mod+Shift+5 { move-column-to-workspace focus=false 5; }
        Mod+Shift+6 { move-column-to-workspace focus=false 6; }
        Mod+Shift+7 { move-column-to-workspace focus=false 7; }
        Mod+Shift+8 { move-column-to-workspace focus=false 8; }
        Mod+Shift+9 { move-column-to-workspace focus=false 9; }

        Print { screenshot show-pointer=false; }
        Ctrl+Print { screenshot-screen write-to-disk=false; }
        Alt+Print { screenshot-window write-to-disk=false; }

        Mod+WheelScrollDown { focus-workspace-down; }
        Mod+WheelScrollUp { focus-workspace-up; }
        Mod+Shift+WheelScrollDown { focus-column-left; }
        Mod+Shift+WheelScrollUp { focus-column-right; }
        Mod+WheelScrollRight { focus-column-right; }
        Mod+WheelScrollLeft { focus-column-left; }

        XF86AudioRaiseVolume { spawn "${changeVolume}" "up"; }
        XF86AudioLowerVolume { spawn "${changeVolume}" "down"; }
        XF86AudioMute { spawn "${changeVolume}" "mute"; }
        XF86AudioMicMute { spawn "wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"; }

        XF86AudioNext { spawn "playerctl" "next"; }
        XF86AudioPrev { spawn "playerctl" "previous"; }
        XF86AudioPlay { spawn "playerctl" "play-pause"; }
        XF86AudioPause { spawn "playerctl" "play-pause"; }

        XF86MonBrightnessUp allow-when-locked=true {
            spawn "${changeBrightness}" "up"
        }
        XF86MonBrightnessDown allow-when-locked=true {
            spawn "${changeBrightness}" "down"
        }
    }
    window-rule {
        match is-window-cast-target=true
        border {
            active-color "#f38ba8"
            inactive-color "#7d0d2d"
        }
    }
    window-rule {
        match app-id="firefox|vesktop|spotify"
        open-maximized true
    }

    spawn-at-startup "${pkgs.xfce.xfce4-notifyd}/lib/xfce4/notifyd/xfce4-notifyd"

    environment {
        _JAVA_AWT_WM_NONREPARENTING "1"
    }

    xwayland-satellite {
        path "${getExe pkgs.xwayland-satellite}"
    }

    debug {
        // Focus on window activation
        honor-xdg-activation-with-invalid-serial
    }
  '';

  services.swayidle = let
    screen-blank-timeout = 15 * minutes;
    lock-after-blank-timeout = 15 * seconds;
    sleep-timeout = 45 * minutes;

    seconds = 1;
    minutes = 60;

    niri = getExe pkgs.niri;
    systemctl = "${pkgs.systemd}/bin/systemctl";
    loginctl = "${pkgs.systemd}/bin/loginctl";
    playerctl = getExe pkgs.playerctl;
    swaylock = getExe pkgs.swaylock;

    lock-session = pkgs.writeShellScript "lock-session" ''
      ${swaylock} -f

      ${playerctl} pause 2>/dev/null || true
      # can cause premature suspend if using laptop with lid closed
      ${niri} msg action power-off-monitors
    '';

    before-sleep = pkgs.writeShellScript "before-sleep" ''
      ${loginctl} lock-session
    '';
  in {
    enable = true;
    timeouts = [
      {
        timeout = screen-blank-timeout;
        command = "${niri} msg action power-off-monitors";
      }
      {
        timeout = screen-blank-timeout + lock-after-blank-timeout;
        command = "${loginctl} lock-session";
      }
      {
        timeout = sleep-timeout;
        command = "${systemctl} sleep";
      }
    ];
    events = [
      {
        event = "lock";
        command = lock-session.outPath;
      }
      {
        event = "before-sleep";
        command = before-sleep.outPath;
      }
    ];
  };

  programs.swaylock = {
    enable = true;
    settings = {
      color = "000000";
      inside-color = "ffffff1c";
      ring-color = "ffffff3e";
      line-color = "ffffff00";
      key-hl-color = "00000080";
      ring-ver-color = "00000000";
      separator-color = "22222260";
      inside-ver-color = "0000001c";
      ring-clear-color = "ff994430";
      inside-clear-color = "ff994400";
      ring-wrong-color = "e34040ff";
      inside-wrong-color = "00000000";
      text-ver-color = "00000000";
      text-wrong-color = "00000000";
      text-caps-lock-color = "00000000";
      text-clear-color = "00000000";
      line-clear-color = "00000000";
      line-wrong-color = "00000000";
      line-ver-color = "00000000";
      text-color = "db3300ff";
    };
  };

  home.packages = with pkgs; [
    wl-clipboard
    xfce.xfce4-notifyd
  ];
}
