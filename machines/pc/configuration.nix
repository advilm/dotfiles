{
  inputs,
  nixosModules,
  pkgs,
  user,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.common-gpu-amd
    inputs.nixos-hardware.nixosModules.common-pc-ssd

    "${nixosModules}/common"

    "${nixosModules}/common"
    "${nixosModules}/desktops/hyprland"
    "${nixosModules}/programs/docker"
    "${nixosModules}/programs/nautilus"
    "${nixosModules}/programs/nh"
    "${nixosModules}/programs/obs-studio"
    "${nixosModules}/programs/steam"
    "${nixosModules}/programs/virt-manager"
    "${nixosModules}/services/openssh"
  ];

  # plex
  networking.firewall.allowedTCPPorts = [32400];

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  services.printing = {
    enable = true;
    drivers = with pkgs; [
      cups-filters
      cups-browsed
    ];
  };
}
