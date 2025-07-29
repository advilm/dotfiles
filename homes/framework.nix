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
  
  wayland.windowManager.hyprland.settings = {
    input.kb_variant = "dvorak";
    gestures = {
      workspace_swipe = true;
      workspace_swipe_invert = false;
      # remove swipe animation
      workspace_swipe_min_speed_to_force = 0;
      workspace_swipe_distance = 2;
      workspace_swipe_cancel_ratio = 0.01;
    };
    binde = [
      ",XF86MonBrightnessDown, exec, brightnessctl s 5-%"
      ",XF86MonBrightnessUp, exec, brightnessctl s 5+%"
    ];
  };
}