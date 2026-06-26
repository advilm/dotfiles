{user, userConfig, ...}: {
  services.openssh.enable = true;
  users.users.${user} = {
    openssh.authorizedKeys.keys = userConfig.ssh_keys;
  };
}
