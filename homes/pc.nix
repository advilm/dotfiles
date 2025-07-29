{ hmModules, ... }: {
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
    "${hmModules}/programs/fish"
    "${hmModules}/programs/fzf"
    "${hmModules}/programs/git"
    "${hmModules}/programs/vesktop"
    "${hmModules}/programs/vscode"
    "${hmModules}/programs/waybar"
    "${hmModules}/programs/yazi"
    "${hmModules}/services/kanshi"
    "${hmModules}/services/playerctld"
  ];
}