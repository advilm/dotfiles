_: {
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;

  programs.fish.loginShellInit = ''
    if uwsm check may-start
      exec uwsm start default
    end
  '';
}
