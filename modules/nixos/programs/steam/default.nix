{pkgs, ...}: {
  programs = {
    steam = {
      enable = true;
      package = pkgs.steam.override {
        # extraArgs = "-forcedesktopscaling=2";
        # https://github.com/YaLTeR/niri/wiki/Application-Issues#steam
        extraArgs = "-system-composer";
      };
      localNetworkGameTransfers.openFirewall = true;
      remotePlay.openFirewall = true;
      gamescopeSession.enable = true;
      extest.enable = true; # Support Steam Input
    };

    gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}
