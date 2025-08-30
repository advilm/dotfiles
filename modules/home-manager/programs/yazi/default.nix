{pkgs, ...}: {
  home.packages = with pkgs; [
    ueberzugpp
  ];
  programs.yazi = {
    enable = true;
    enableFishIntegration = true;
  };
}
