{pkgs, ...}: {
  programs.niri.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };
  programs.xwayland.enable = true;
  services.dbus.implementation = "broker";
}
