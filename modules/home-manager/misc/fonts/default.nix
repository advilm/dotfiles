{pkgs, ...}: {
  home.packages = with pkgs; [
    corefonts
    vista-fonts
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = ["Liberation Serif"];
      sansSerif = ["Ubuntu"];
      monospace = ["JetBrainsMono Nerd Font"];
      emoji = ["Twitter Color Emoji"];
    };
  };
}
