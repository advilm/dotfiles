_: {
  programs.vesktop = {
    enable = true;
    settings = {
      discordBranch = "stable";
      tray = false;
      minimizeToTray = false;
      staticTitle = true;
      enableMenu = false;
      hardwareAcceleration = true;
      hardwareVideoAcceleration = true;
      arRPC = true;
      appBadge = false;
      disableMinSize = true;
      customTitleBar = false;

      enableSplashScreen = false;
    };
  };
}
