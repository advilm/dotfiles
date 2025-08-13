{ pkgs, ... }: {
  vim.lazy.plugins."snacks.nvim" = {
    package = pkgs.vimPlugins.snacks-nvim;
    lazy = false;
    keys = [
      { mode = ["n"]; key = "<leader>gs"; lua = true; action = "function() Snacks.lazygit() end"; }
    ];
  };
  vim.extraPackages = [ pkgs.lazygit ];
} 
