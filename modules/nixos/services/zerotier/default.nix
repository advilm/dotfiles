{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    zerotierone
  ];
}