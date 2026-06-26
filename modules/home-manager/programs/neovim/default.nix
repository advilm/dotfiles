{customPackages, ...}: {
  home.packages = [
    customPackages.neovim
  ];
  home.sessionVariables = {
    EDITOR = "nvim";
  };
}
