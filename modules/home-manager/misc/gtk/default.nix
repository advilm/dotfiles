{ pkgs, ... }:
{
  home.packages = with pkgs; [
    dconf
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Matcha-dark-azul";
      package = pkgs.matcha-gtk-theme;
    };
    iconTheme = {
      name = "Qogir-Dark";
      package = pkgs.qogir-icon-theme;
    };
    gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
  };

  qt = {
    enable = true;
    platformTheme.name = "qt5ct";
    style.name = "kvantum";
  };

  xdg.configFile = {
    "Kvantum/Matcha-azul-dark".source = "${
      (pkgs.fetchFromGitHub {
        owner = "R0CKH0PP3R";
        repo = "kvantum";
        rev = "23a6178562634a596d2d39e7d69beeb54ee4c650";
        sha256 = "sha256-wKIglQ/v5anxNM9je+Li+BT3BQJFO46HMDHQSCv6IzA=";
      })
    }/Matcha-azul-dark";

    "Kvantum/kvantum.kvconfig".text = ''
      [General]
      theme=Matcha-azul-dark
    '';
  };

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
}
