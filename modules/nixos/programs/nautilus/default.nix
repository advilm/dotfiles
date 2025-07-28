{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nautilus
  ];
  programs.nautilus-open-any-terminal.enable = true;
  programs.nautilus-open-any-terminal.terminal = "alacritty";
}