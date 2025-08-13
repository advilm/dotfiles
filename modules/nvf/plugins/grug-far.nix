{ pkgs, lib, ... }: {
  vim.lazy.plugins."grug-far.nvim" = {
    package = pkgs.vimPlugins.grug-far-nvim;
    setupModule = "grug-far";
    cmd = "GrugFar";
    keys =  [
      { mode = ["n"]; key = "<leader>sr"; lua = true; action = "function() require('grug-far').open() end"; }
      { mode = ["n"]; key = "<leader>sf"; lua = true; action = 
        "function() require('grug-far').open({ prefills = { paths = vim.fn.expand(\"%\") } }) end"; }
    ];
  };
} 