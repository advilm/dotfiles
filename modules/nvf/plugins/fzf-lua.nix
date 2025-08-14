{ pkgs, ... }: {
  vim.lazy.plugins."fzf-lua" = {
    package = pkgs.vimPlugins.fzf-lua;
    setupModule = "fzf-lua";
    keys = [
      { mode = ["n"]; key = "<leader>ff"; lua = true; action = "function() require('fzf-lua').files() end"; }
      { mode = ["n"]; key = "<leader>fg"; lua = true; action = "function() require('fzf-lua').live_grep() end"; }
      { mode = ["n"]; key = "<leader>fb"; lua = true; action = "function() require('fzf-lua').buffers() end"; }
    ];
  };

  vim.extraPackages = with pkgs; [ fzf ripgrep ];
} 
