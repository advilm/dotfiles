{
  inputs,
  nixosModules,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.nixos-hardware.nixosModules.framework-11th-gen-intel

    "${nixosModules}/common"
    "${nixosModules}/desktops/niri"
    "${nixosModules}/programs/docker"
    "${nixosModules}/programs/nautilus"
    "${nixosModules}/programs/nh"
    "${nixosModules}/programs/obs-studio"
    "${nixosModules}/programs/steam"
    "${nixosModules}/programs/virt-manager"
    "${nixosModules}/services/keyd"
    "${nixosModules}/services/openssh"
    "${nixosModules}/services/tlp"
    "${nixosModules}/services/zerotier"
  ];

  # boot.kernelParams = [
  #   "i915.force_probe=!9a49"
  #   "xe.force_probe=9a49"
  # ];

  systemd.sleep.extraConfig = "HibernateDelaySec=1h";
  services.logind.settings.Login.HandleLidSwitch = "suspend-then-hibernate";
  powerManagement.resumeCommands = ''
    systemctl restart tlp.service
  '';

  hardware.framework.enableKmod = true;
  # hardware.framework.laptop13.audioEnhancement.enable = true;

  # enable when doing firmware updates
  services.fwupd.enable = false;

  console.keyMap = "dvorak";

  # use package cache on laptop
  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
    ];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };

  programs.ghidra = {
    enable = true;
    gdb = true;
  };

  services.thermald.enable = true;
}
