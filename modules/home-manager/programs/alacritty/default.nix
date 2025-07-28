{ ... }: {
  programs.alacritty = {
    enable = true;
    settings = {
      window.padding = {
        x = 6;
        y = 6;
      };
    };
    theme = "alabaster_dark";
  };
}