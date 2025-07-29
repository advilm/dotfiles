{
  inputs,
  host,
  nixosModules,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-11th-gen-intel

    "${nixosModules}/common"
    "${nixosModules}/desktops/hyprland"
    "${nixosModules}/programs/docker"
    "${nixosModules}/programs/nautilus"
    "${nixosModules}/programs/nh"
    "${nixosModules}/programs/overskride"
    "${nixosModules}/programs/steam"
    "${nixosModules}/programs/brightnessctl"
    "${nixosModules}/services/keyd"
    "${nixosModules}/services/openssh"
  ];

  hardware.framework.enableKmod = true;
  hardware.framework.laptop13.audioEnhancement.enable = true;

  # limit to laptop keyboard
  services.keyd.keyboards.default.ids = [ "0001:0001:70533846" ];
}
