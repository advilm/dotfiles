_: {
  flake.registry.niri.nixos = _settings: import ../../../modules/nixos/desktops/niri;
  flake.registry.niri.homeManager = _settings: import ../../../modules/home-manager/desktops/niri;
}
