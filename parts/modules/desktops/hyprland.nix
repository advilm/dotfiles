_: {
  flake.registry.hyprland.nixos = _settings: import ../../../modules/nixos/desktops/hyprland;
  flake.registry.hyprland.homeManager = _settings: import ../../../modules/home-manager/desktops/hyprland;
}
