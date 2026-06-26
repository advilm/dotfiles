{pkgs, ...}: {
  home.packages = with pkgs; [
    intel-gpu-tools
  ];

  wayland.windowManager.hyprland.settings = {
    input.touchpad = {
      disable_while_typing = "yes";
      scroll_factor = 0.7;
      drag_lock = 1;
    };
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
