_: {
  xdg = {
    enable = true;

    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = [ "firefox.desktop" ];
        "x-scheme-handler/https" = [ "firefox.desktop" ];
        "text/html" = [ "firefox.desktop" ];
        "text/plain" = [ "nvim.desktop" ];
      };
    };

    # set alacritty as the preferred terminal
    terminal-exec = {
      enable = true;
      settings = {
        default = [ "Alacritty.desktop" ];
      };
    };

    # portal = {
    #   enable = true;
    #   xdgOpenUsePortal = true;
    #   extraPortals = [
    #     pkgs.xdg-desktop-portal-gtk
    #   ];
    #   config.common.default = ["gtk"];
    #   config.hyprland.default = ["hyprland" "gtk"];
    # };
  };
}
