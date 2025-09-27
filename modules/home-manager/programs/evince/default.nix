{pkgs, ...}: {
  home.packages = with pkgs; [
    evince
  ];

  xdg.mimeApps.defaultApplications = {
    "application/pdf" = ["org.gnome.Evince.desktop"];
  };
}
