{
  pkgs,
  user,
  ...
}: {
  home.username = user;
  home.homeDirectory = "/home/${user}";

  home.packages = with pkgs; [
    ncdu
    ripgrep
    fd
  ];

  programs.htop = {
    enable = true;
    settings = {
      show_cpu_frequency = 1;
      show_cpu_temperature = 1;
    };
  };

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
