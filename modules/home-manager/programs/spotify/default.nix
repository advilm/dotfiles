{pkgs, ...}: {
  home.packages = with pkgs; [
    nur.repos.nltch.spotify-adblock
  ];
}
