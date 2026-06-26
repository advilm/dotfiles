_: {
  flake.registry.river.nixos = _settings: import ../../../modules/nixos/desktops/river;
  flake.registry.river.homeManager = _settings: import ../../../modules/home-manager/desktops/river;
}
