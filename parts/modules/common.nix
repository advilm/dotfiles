_: {
  flake.registry.common.nixos = settings: import ../../modules/nixos/common;
  flake.registry.common.homeManager = _settings: import ../../modules/home-manager/common;
}
