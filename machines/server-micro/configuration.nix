{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.disko.nixosModules.disko
    ./disko.nix
  ];

  hardware.facter.reportPath = ./facter.json;

  system.stateVersion = "25.05";
}
