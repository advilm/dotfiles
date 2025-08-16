{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gpu-screen-recorder
    gpu-screen-recorder-gtk
  ];
}
