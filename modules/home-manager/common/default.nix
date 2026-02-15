{
  pkgs,
  user,
  ...
}: {
  home.username = user;
  home.homeDirectory = "/home/${user}";

  home.packages = with pkgs; [
    jellyfin-desktop
    bitwarden-desktop
    mpv
    ncdu
    pavucontrol
    ripgrep
    fd
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

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting
    '';
  };

  programs.starship = {
    enable = true;
    enableFishIntegration = true;
    settings.add_newline = false;
  };

  home.stateVersion = "25.05";

  programs.home-manager.enable = true;
}
