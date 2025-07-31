# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, inputs, user, host, ... }:

{
  nixpkgs.config.allowUnfree = true;

  hardware.graphics.enable = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.tmp.useTmpfs = true;

  networking.hostName = host;
  networking.networkmanager.enable = true;

  time.timeZone = "America/Los_Angeles";

  i18n.defaultLocale = "en_US.UTF-8";
  console.keyMap = lib.mkDefault "us";

  fonts.packages = with pkgs; [
    ubuntu_font_family
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans
    mplus-outline-fonts.githubRelease
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    twitter-color-emoji
  ];

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    shell = pkgs.fish;
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment = {
    systemPackages = with pkgs; [
        vim
        git
        wget
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      ADW_DISABLE_PORTAL = "1"; # TODO: Try disabling and see if it still works
    };
  };

  programs.fish.enable = true;
  programs.gnupg.agent.enable = true;
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion.
  system.stateVersion = "25.05";

}