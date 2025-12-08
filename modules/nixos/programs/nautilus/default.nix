{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    nautilus
    file-roller
  ];
  programs.nautilus-open-any-terminal.enable = true;
  programs.nautilus-open-any-terminal.terminal = "alacritty";
  services.gvfs.enable = true;
}
