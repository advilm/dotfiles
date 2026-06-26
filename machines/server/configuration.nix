{
  lib,
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.lanzaboote.nixosModules.lanzaboote
    inputs.disko.nixosModules.disko
    inputs.disko-zfs.nixosModules.default
    ./disko.nix
  ];

  hardware.facter.reportPath = ./facter.json;

  # Automatically blank the console after 10 minutes of inactivity
  boot.kernelParams = ["consoleblank=600"];

  # Secure Boot
  boot.loader.systemd-boot.enable = lib.mkForce false;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  # TPM based LUKS encryption
  boot.initrd.systemd.enable = true;
  boot.initrd.luks.devices.cryptroot = {
    device = "/dev/disk/by-partlabel/disk-system-luks";
    allowDiscards = true;
    crypttabExtraOpts = ["tpm2-device=auto"];
  };

  # Fix throttling issue
  boot.initrd.kernelModules = ["msr"];
  boot.initrd.systemd.storePaths = [
    pkgs.msr-tools
  ];
  boot.initrd.systemd.services.msr-tweak = {
    description = "Apply MSR tweak";
    wantedBy = ["initrd.target"];
    after = ["systemd-modules-load.service"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${lib.getExe' pkgs.msr-tools "wrmsr"} -a 0x1FC 0x0";
    };
  };

  boot.supportedFilesystems = ["zfs"];
  networking.hostId = "ec83f9b7";

  services.zfs = {
    autoScrub.enable = true;
    trim.enable = true;
    autoSnapshot.enable = true;
  };

  environment.systemPackages = with pkgs; [
    sbctl
    cryptsetup
    zfs
  ];

  sops = {
    defaultSopsFile = ./secrets.yaml;
    age.sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    age.keyFile = "/var/lib/sops-nix/key.txt";
    age.generateKey = true;
  };

  # make sure the zfs-media.key is available in the initrd for unlocking the zfs pool
  sops.secrets.zfs_media_key = {};
  boot.initrd.secrets = {
    "/zfs_media_key" = config.sops.secrets.zfs_media_key.path;
  };

  system.stateVersion = "25.05";
}
