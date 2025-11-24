{userConfig, ...}: {
  programs.git = {
    enable = true;
    settings.user = {
      inherit (userConfig) email name;
    };
    signing.key = userConfig.signing_key;
    signing.signByDefault = true;
  };

  programs.lazygit = {
    enable = true;
    settings = {
      git.overrideGpg = true;
    };
  };
}
