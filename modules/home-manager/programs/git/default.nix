{userConfig, ...}: {
  programs.git = {
    enable = true;
    userEmail = userConfig.email;
    userName = userConfig.name;
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
