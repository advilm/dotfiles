{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nur.repos.nltch.spotify-adblock
  ];
}