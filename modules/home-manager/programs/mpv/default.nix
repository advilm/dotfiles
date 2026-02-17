_: {
  programs.mpv = {
    enable = true;
    bindings = {
      "RIGHT" = "seek 5 exact";
      "LEFT" = "seek -5 exact";
    };
  };
}
