# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  lib,
  pkgs,
  inputs,
  user,
  host,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  hardware.enableRedistributableFirmware = true;

  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
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

  # Allow qtwebengine-5.15.19 to be installed for jellyfin-media-player
  nixpkgs.config.permittedInsecurePackages = [
    "qtwebengine-5.15.19"
  ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;

    kernelPackages = pkgs.linuxPackages_latest;

    tmp.useTmpfs = true;
  };

  networking = {
    hostName = host;

    networkmanager = {
      enable = true;
      dns = "none";
      wifi.backend = "iwd";
      plugins = [pkgs.networkmanager-openvpn];
    };

    nameservers = ["1.1.1.1"];
  };

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

  # for redshift
  location.provider = "geoclue2";

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "audio"
      "video"
      "networkmanager"
      "docker"
      "i2c"
    ];
    shell = pkgs.fish;
  };

  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).
  environment = {
    systemPackages = with pkgs; [
      ddcutil
      git
      vim
      wget
      seahorse
      libsecret
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      ADW_DISABLE_PORTAL = "1"; # TODO: Try disabling and see if it still works
    };
  };

  documentation.man.generateCaches = false;

  programs.fish.enable = true;
  programs.gnupg.agent.enable = true;
  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    extraConfig.pipewire = {
      "10-block-agc" = {
        "pulse.rules" = [
          {
            # Block every client from touching source (mic) volume
            matches = [
              {"application.process.binary" = "~.*";}
            ];
            actions = {
              quirks = ["block-source-volume"];
            };
          }
        ];
      };
    };
    wireplumber.extraConfig = {
      "50-hsp-autoswitch-disable" = {
        "wireplumber.settings" = {
          "bluetooth.autoswitch-to-headset-profile" = false;
        };
      };
    };
  };

  # secrets manager
  services.gnome.gnome-keyring.enable = true;

  # skip typing username on login
  services.getty.loginOptions = "-p -- ${user}";
  services.getty.extraArgs = ["--skip-login"];

  services.upower = {
    enable = true;
    # HybridSleep at 3% battery
    percentageAction = 3;
  };

  hardware.bluetooth = {
    enable = true;
    settings.General = {
      JustWorksRepairing = "always";
      Experimental = true;
    };
  };

  # for ddcutil to be able to control monitor brightness
  hardware.i2c.enable = true;

  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion.
  system.stateVersion = "25.05";
}
