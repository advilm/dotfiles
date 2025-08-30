{ hmModules, pkgs, ... }:
{
  imports = [
    "${hmModules}/common"
    "${hmModules}/misc/cursor"
    "${hmModules}/misc/fonts"
    "${hmModules}/misc/gtk"
    "${hmModules}/misc/xdg"
    "${hmModules}/desktops/hyprland"
    "${hmModules}/programs/alacritty"
    "${hmModules}/programs/anyrun"
    "${hmModules}/programs/firefox"
    "${hmModules}/programs/fzf"
    "${hmModules}/programs/git"
    "${hmModules}/programs/gpu_screen_recorder"
    "${hmModules}/programs/overskride"
    "${hmModules}/programs/signal"
    "${hmModules}/programs/spotify"
    "${hmModules}/programs/discord"
    "${hmModules}/programs/vscode"
    "${hmModules}/programs/yazi"
    "${hmModules}/services/gammastep"
    "${hmModules}/services/kanshi"
    "${hmModules}/services/playerctld"
  ];

  home.packages = with pkgs; [
    wineWowPackages.stable
  ];
}
