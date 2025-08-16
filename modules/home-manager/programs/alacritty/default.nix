_: {
  programs.alacritty = {
    enable = true;
    settings = {
      window.padding = {
        x = 6;
        y = 6;
      };
      colors = {
        primary = {
          background = "#090e15";
          foreground = "#c0caf5";
        };
        cursor = {
          text = "#1a1b26";
          cursor = "#c0caf5";
        };
        normal = {
          black = "#15161e";
          red = "#f7768e";
          green = "#9ece6a";
          yellow = "#e0af68";
          blue = "#7aa2f7";
          magenta = "#bb9af7";
          cyan = "#7dcfff";
          white = "#a9b1d6";
        };
        bright = {
          black = "#414868";
          red = "#ff899d";
          green = "#9fe044";
          yellow = "#faba4a";
          blue = "#8db0ff";
          magenta = "#c7a9ff";
          cyan = "#a4daff";
          white = "#c0caf5";
        };
        indexed_colors = [
          { index = 16; color = "#ff9e64"; }
          { index = 17; color = "#db4b4b"; }
        ];
      };
    };
  };
}
