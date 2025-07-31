{ lib, inputs, pkgs, user, ...}: {
  home.username = user;
  home.homeDirectory = "/home/${user}";

  home.packages = with pkgs; [
    jellyfin-media-player
    mpv
    neovim
    pavucontrol
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  programs.htop = {
    enable = true;
    settings = {
      show_cpu_frequency = 1;
      show_cpu_temperature = 1;
    };
  };

  programs.mangohud.enable = true;

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
