_: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      theme = "dark";
      window-padding-x = 6;
      window-padding-y = 6;
    };
    themes.dark = {
      # Colors
      background = "#090e15";
      foreground = "#c0caf5";
      cursor-color = "#c0caf5";
      cursor-text = "#1a1b26";

      # Normal colors
      palette = [
        "0=#15161e" # black
        "1=#f7768e" # red
        "2=#9ece6a" # green
        "3=#e0af68" # yellow
        "4=#7aa2f7" # blue
        "5=#bb9af7" # magenta
        "6=#7dcfff" # cyan
        "7=#a9b1d6" # white

        # Bright colors
        "8=#414868" # bright black
        "9=#ff899d" # bright red
        "10=#9fe044" # bright green
        "11=#faba4a" # bright yellow
        "12=#8db0ff" # bright blue
        "13=#c7a9ff" # bright magenta
        "14=#a4daff" # bright cyan
        "15=#c0caf5" # bright white

        # Extra indexed colors
        "16=#ff9e64"
        "17=#db4b4b"
      ];
    };
  };
}
