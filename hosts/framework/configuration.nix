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
    "${nixosModules}/programs/signal"
    "${nixosModules}/programs/spotify"
    "${nixosModules}/programs/steam"
    "${nixosModules}/programs/brightnessctl"
    "${nixosModules}/services/keyd"
    "${nixosModules}/services/openssh"
    "${nixosModules}/services/tlp"
  ];

  hardware.framework.enableKmod = true;
  hardware.framework.laptop13.audioEnhancement.enable = true;

  services.fwupd.enable = true;

  # limit to laptop keyboard
  services.keyd.keyboards.default.ids = [ "0001:0001:70533846" ];
}
