{ pkgs, lib, ... }: {
  vim.lazy.plugins."treesj" = {
    package = pkgs.vimPlugins.treesj;
    setupModule = "treesj";
    keys = [
      { mode = ["n"]; key = "<leader>m"; lua = true; action = "function() require('treesj').toggle() end"; }
      { mode = ["n"]; key = "<leader>M"; lua = true; action = 
        "function() require('treesj').toggle({ split = { recursive = true } }) end"; }
    ];
  };
} 