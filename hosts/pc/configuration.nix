{
  inputs,
  host,
  nixosModules,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    "${nixosModules}/common"
    "${nixosModules}/desktops/hyprland"
    "${nixosModules}/programs/docker"
    "${nixosModules}/programs/nautilus"
    "${nixosModules}/programs/nh"
    "${nixosModules}/programs/overskride"
    "${nixosModules}/programs/steam"
    "${nixosModules}/services/openssh"
  ];

  networking.firewall.allowedTCPPorts = [ 32400 ];
}