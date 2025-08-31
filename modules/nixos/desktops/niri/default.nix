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

  programs.uwsm.enable = true;
  programs.uwsm.waylandCompositors = {
    niri = {
      prettyName = "Niri";
      comment = "Niri - UWSM";
      binPath = "/run/current-system/sw/bin/niri-session";
    };
  };
  programs.fish.loginShellInit = ''
    if uwsm check may-start
      exec uwsm start default
    end
  '';

  services.playerctld.enable = true;
}
