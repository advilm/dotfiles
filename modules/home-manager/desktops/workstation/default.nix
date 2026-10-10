{pkgs, ...}: {
  home.packages = with pkgs; [
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
