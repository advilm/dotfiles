{user, ...}: {
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep 3";
    clean.dates = "monthly";
    flake = "/home/${user}/.dotfiles";
  };
}
