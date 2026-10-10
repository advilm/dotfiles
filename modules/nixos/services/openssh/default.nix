{
  user,
  userConfig,
  ...
}: {
  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
      settings.PermitRootLogin = "no";
    };
  };
  users.users.${user} = {
    openssh.authorizedKeys.keys = userConfig.ssh_keys;
  };
}
