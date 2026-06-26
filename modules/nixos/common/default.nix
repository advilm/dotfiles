# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  lib,
  pkgs,
  inputs,
  user,
  host,
  moduleSettings,
  ...
}: let
  wheelNeedsPassword = lib.attrByPath ["common" "sudo" "wheelNeedsPassword"] true moduleSettings;
  useNetworkManager = lib.attrByPath ["common" "networking" "useNetworkManager"] true moduleSettings;
in {
  nixpkgs.config.allowUnfree = true;

  hardware.enableRedistributableFirmware = true;

  nix = {
    package = pkgs.lixPackageSets.latest.lix;
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      trusted-users = [user];
    };
    # use nixpkgs from flake for nix commands
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    registry.nixpkgs = {
      from = {
        id = "nixpkgs";
        type = "indirect";
      };
      flake = inputs.nixpkgs;
    };
  };

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    kernelParams = ["quiet" "loglevel=3" "systemd.show_status=auto" "rd.udev.log_level=3"];

    kernelPackages = pkgs.linuxPackages_latest;

    tmp.useTmpfs = true;
  };

  networking = {
    hostName = host;
    nameservers = ["1.0.0.1"];
    networkmanager = {
      enable = useNetworkManager;
      dns = "none";
      wifi.backend = "iwd";
      plugins = [pkgs.networkmanager-openvpn pkgs.networkmanager-openconnect];
    };
  };

  hardware.facter.detected.dhcp.enable = false;

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = lib.mkDefault "us";

  users.users.${user} = {
    isNormalUser = true;
    shell = pkgs.fish;
    extraGroups = ["wheel" "networkmanager"];
  };

  environment.systemPackages = with pkgs; [
    git
    vim
    wget
  ];

  documentation.man.generateCaches = false;

  programs.fish.enable = true;
  programs.gnupg.agent.enable = true;
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  security.sudo.wheelNeedsPassword = wheelNeedsPassword;

  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion.
  system.stateVersion = "25.05";
}
