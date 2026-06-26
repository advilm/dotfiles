{pkgs, user, ...}: {
  time.timeZone = "America/Los_Angeles";

  fonts.packages = with pkgs; [
    ubuntu-classic
    liberation_ttf
    noto-fonts
    noto-fonts-cjk-sans
    mplus-outline-fonts.githubRelease
    nerd-fonts.jetbrains-mono
    nerd-fonts.meslo-lg
    twitter-color-emoji
  ];

  location.provider = "geoclue2";

  users.users.${user}.extraGroups = [
    "audio"
    "video"
    "i2c"
  ];

  environment = {
    systemPackages = with pkgs; [
      ddcutil
      seahorse
      libsecret
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      ADW_DISABLE_PORTAL = "1";
    };
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    extraConfig.pipewire-pulse = {
      "10-block-agc" = {
        "pulse.rules" = [
          {
            matches = [
              {"application.process.binary" = "electron";}
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

  services.gnome.gnome-keyring.enable = true;

  services.upower = {
    enable = true;
    percentageAction = 3;
  };

  hardware.bluetooth = {
    enable = true;
    settings.General = {
      JustWorksRepairing = "always";
      Experimental = true;
    };
  };

  hardware.i2c.enable = true;
}
