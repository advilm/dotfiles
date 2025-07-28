{ lib, inputs, pkgs, user, ...}: {
  home.username = user;
  home.homeDirectory = "/home/${user}";

  home.packages = with pkgs; [
    neovim
    jellyfin-media-player
    mpv
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
