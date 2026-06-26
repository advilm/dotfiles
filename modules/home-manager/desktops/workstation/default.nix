{pkgs, ...}: {
  home.packages = with pkgs; [
    jellyfin-desktop
    thunderbird
    pavucontrol
    loupe
  ];

  home.sessionVariables = {
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  programs.mangohud.enable = true;
}
