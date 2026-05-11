{
  lib,
  pkgs,
  ...
}: {
  xdg = {
    enable = true;

    portal = {
      enable = true;
      xdgOpenUsePortal = true;
      extraPortals = [pkgs.xdg-desktop-portal-gnome];
      config.common.default = "gnome";
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
        "application/pdf" = lib.mkDefault "firefox.desktop";
        "text/html" = "firefox.desktop";
        "text/plain" = "nvim.desktop";
        "application/x-zerosize" = "nvim.desktop";
      };
      associations.added = {
        "application/pdf" = "firefox.desktop";
      };
    };

    # set alacritty as the preferred terminal
    terminal-exec = {
      enable = true;
      settings = {
        default = ["Alacritty.desktop"];
      };
    };
  };
}
