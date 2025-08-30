{pkgs, ...}: {
  imports = [../shared/waybar];
  xdg.configFile."niri/config.kdl".source = ./config.kdl;

  services.swaync.enable = true;

  home.packages = with pkgs; [
    wl-clipboard
  ];
}
