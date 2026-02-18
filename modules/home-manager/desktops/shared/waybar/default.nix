{pkgs, ...}: {
  home.packages = with pkgs;
    [
      font-awesome
    ]
    ++ [
      (pkgs.stdenv.mkDerivation {
        name = "battery-ttf";
        src = ../../../fonts;
        dontBuild = true;
        installPhase = ''
          mkdir -p $out/share/fonts/truetype
          cp battery.ttf $out/share/fonts/truetype
        '';
      })
    ];

  programs.waybar = {
    enable = true;

    package = pkgs.waybar.overrideAttrs (old: {
      src = pkgs.fetchFromGitHub {
        owner = "advilm";
        repo = "Waybar";
        rev = "60e8c38cbdfdd4484e9d19ab59d04524c73a633c";
        sha256 = "sha256-s648edbzaZt/4DRvyCpWHnjcbN7nxU9Fj7VZ+irRQ/8=";
      };
    });

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

      #taskbar button:hover {
        color: inherit;
        background-color: #353a47;
        box-shadow: inset 0 -2px #82AAFF;
      }

      #taskbar button.active {
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
        position = "top";
        layer = "top";
        modules-left = [
          "niri/workspaces"
          "niri/taskbar"
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
        "niri/workspaces" = {
          format = "{icon}";
          on-scroll-up = "niri msg action focus-workspace-up";
          on-scroll-down = "niri msg action focus-workspace-down";
        };
        "niri/taskbar" = {
          on-click = "activate";
          on-click-middle = "close";
          on-click-right = "maximize";
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
          format = "<span color='#82AAFF' rise='1pt'></span> {:%Y-%m-%d}";
          tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
        };
        "clock#time" = {
          interval = 1;
          timezones = ["America/Los_Angeles"];
          format = "<span color='#82AAFF' rise='1pt'>󰥔</span> {:%H:%M}";
          tooltip-format = "";
        };
        battery = {
          format = "<span color='#82AAFF' size='small'>{icon}</span> {capacity}%";
          format-icons = ["" "" "" "" ""];
        };
      }
    ];
  };
}
