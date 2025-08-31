{
  hmModules,
  pkgs,
  ...
}: {
  imports = [
    "${hmModules}/common"
    "${hmModules}/misc/cursor"
    "${hmModules}/misc/fonts"
    "${hmModules}/misc/gtk"
    "${hmModules}/misc/xdg"
    "${hmModules}/desktops/niri"
    "${hmModules}/programs/alacritty"
    "${hmModules}/programs/anyrun"
    "${hmModules}/programs/brightnessctl"
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
  ];

  home.packages = with pkgs; [
    intel-gpu-tools
  ];

  wayland.windowManager.hyprland.settings = {
    input.kb_variant = "dvorak";
    input.touchpad = {
      disable_while_typing = "yes";
      scroll_factor = 0.7;
      drag_lock = 1;
    };
    device = [
      {
        name = "yiancar-designs-nk65b";
        kb_variant = "";
      }
    ];
    gestures = {
      workspace_swipe = true;
      workspace_swipe_invert = false;
      # remove swipe animation
      workspace_swipe_min_speed_to_force = 0;
      workspace_swipe_distance = 2;
      workspace_swipe_cancel_ratio = 0.01;
    };
    binde = [
      ",XF86MonBrightnessDown, exec, brightnessctl set -e 5-%"
      ",XF86MonBrightnessUp, exec, brightnessctl set -e 5+%"
    ];
  };
}
