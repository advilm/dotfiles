_: {
  hardware.facter.reportPath = ./facter.json;

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/b9a37788-addf-4951-b198-8ceed661f8f2";
    fsType = "btrfs";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F8CC-AD8E";
    fsType = "vfat";
    options = [
      "fmask=0022"
      "dmask=0022"
    ];
  };

  swapDevices = [
    {device = "/dev/disk/by-uuid/7bf6db1f-0128-4489-9b54-31d8101e7eee";}
  ];

  # boot.kernelParams = [
  #   "i915.force_probe=!9a49"
  #   "xe.force_probe=9a49"
  # ];

  systemd.sleep.settings.Sleep.HibernateDelaySec = "1h";
  services.logind.settings.Login = {
    HandleLidSwitch = "sleep";
    HandleSuspendKey = "sleep";
  };
  powerManagement.resumeCommands = ''
    systemctl restart tlp.service
  '';

  hardware.framework.enableKmod = true;
  # hardware.framework.laptop13.audioEnhancement.enable = true;

  # enable when doing firmware updates
  services.fwupd.enable = false;

  # use package cache on laptop
  nix.settings = {
    substituters = [
      "https://nix-community.cachix.org"
      "https://hyprland.cachix.org"
      "https://anyrun.cachix.org"
    ];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
    ];
  };

  programs.ghidra = {
    enable = true;
    gdb = true;
  };

  services.thermald.enable = true;
}
