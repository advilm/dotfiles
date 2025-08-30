{pkgs, ...}: {
  vim.lazy.plugins."guess-indent.nvim" = {
    package = pkgs.vimPlugins.guess-indent-nvim;
    setupModule = "guess-indent";
  };
}
