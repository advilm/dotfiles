{
  pkgs,
  lib,
  ...
}: {
  programs.niri.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe pkgs.tuigreet} --time --remember --remember-session";
        user = "greeter";
      };
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
  };
  programs.xwayland.enable = true;
  services.dbus.implementation = "broker";

  services.playerctld.enable = true;
}
