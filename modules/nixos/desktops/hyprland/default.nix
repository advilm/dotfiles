{ ... }: {
  hardware.bluetooth.enable = true;

  programs.hyprland.enable = true;
  programs.hyprland.withUWSM  = true;

  # TODO: fish init shell here?
}