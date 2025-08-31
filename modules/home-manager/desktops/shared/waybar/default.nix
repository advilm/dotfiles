{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    font-awesome
    swaybg
  ];

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    style = ''
      * {
        font-family: "MesloLGS Nerd Font Propo";
        font-size: 14px;
      }

      window#waybar {
        box-shadow: inset 0 -2px #444444;
      }

      #workspaces button {
        padding: 0 4px;
        transition-property: all;
        transition-duration: 0.2s;
      }

      #workspaces button.empty {
        color: #575758;
      }

      #workspaces button:hover {
        color: inherit;
        background-color: #353a47;
        box-shadow: inset 0 -2px #82AAFF;
      }

      #workspaces button.active {
        color: inherit;
        background-color: #353a47;
        box-shadow: inset 0 -2px #82AAFF;
      }

      button {
        box-shadow: inset 0 0;
        border-radius: 0;
      }

      .modules-right .module {
        margin: 0 6px;
      }
    '';

    settings = [
      {
        height = 30;

        modules-left = [
          "hyprland/workspaces"
          "niri/workspaces"
          "wlr/taskbar"
        ];
        modules-center = [
          "hyprland/window"
        ];
        modules-right = [
          "network#down"
          "network#up"
          "memory"
          "cpu"
          "battery"
          "clock#date"
          "clock#time"
          "tray"
        ];
        "hyprland/window" = {
          format = "{initialTitle}";
        };
        "hyprland/workspaces" = {
          on-scroll-up = "hyprctl dispatch workspace r+1";
          on-scroll-down = "hyprctl dispatch workspace r-1";
          on-click = "activate";
          all-outputs = true;
          persistent-workspaces = let
            attrSet = lib.genAttrs (builtins.genList (x: builtins.toString (x + 1)) 10) (i: []);
          in
            attrSet;
        };
        "niri/workspaces" = {
          format = "{icon}";
          all-outputs = true;
          on-scroll-up = "niri msg action focus-workspace-up";
          on-scroll-down = "niri msg action focus-workspace-up";
        };
        "wlr/taskbar" = {
          on-click = "activate";
          on-click-middle = "close";
        };
        tray = {
          icon-size = 12;
          spacing = 8;
        };
        "network#down" = {
          interval = 3;
          format = "<span color='#82AAFF'></span> {bandwidthDownBytes}";
          format-disconnected = "";
          tooltip-format = "{ifname} via {gwaddr} 󰊗";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
          max-length = 50;
        };
        "network#up" = {
          interval = 3;
          format = "<span color='#82AAFF'></span> {bandwidthUpBytes}";
          format-disconnected = "";
          tooltip-format = "{ifname} via {gwaddr} 󰊗";
          tooltip-format-wifi = "{essid} ({signalStrength}%) ";
          tooltip-format-ethernet = "{ifname} ";
          max-length = 50;
        };
        memory = {
          interval = 3;
          format = "<span color='#82AAFF'></span> {}%";
        };
        cpu = {
          interval = 3;
          format = "<span color='#82AAFF'></span> {usage}%";
        };
        "clock#date" = {
          interval = 1;
          timezones = ["America/Los_Angeles"];
          format = "<span color='#82AAFF'></span> {:%Y-%m-%d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        "clock#time" = {
          interval = 1;
          timezones = ["America/Los_Angeles"];
          format = "<span color='#82AAFF'>󰥔</span> {:%H:%M}";
          tooltip-format = "";
        };
      }
    ];
  };
}
