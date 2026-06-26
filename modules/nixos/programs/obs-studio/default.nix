{lib, pkgs, moduleSettings, ...}:
let
  enablePlugins = lib.attrByPath ["obs-studio" "enablePlugins"] true moduleSettings;
in {
  programs.obs-studio = {
    enable = true;
    enableVirtualCamera = true;
    plugins = lib.optionals enablePlugins (with pkgs.obs-studio-plugins; [
      droidcam-obs
      obs-backgroundremoval
      obs-vkcapture
    ]);
  };
}
