{ pkgs, ... }: {
  home.pointerCursor = {
    gtk.enable = true;
    hyprcursor.enable = true;
    hyprcursor.size = 24;
    size = 24;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
  };
}