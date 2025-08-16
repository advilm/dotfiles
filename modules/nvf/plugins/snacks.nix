{ pkgs, ... }:
{
  vim.lazy.plugins."snacks.nvim" = {
    package = pkgs.vimPlugins.snacks-nvim;
    setupModule = "snacks";
    lazy = false;
    setupOpts = {
      indent = {
        enable = true;
        animate.enabled = false;
      };
    };
    keys = [
      {
        mode = [ "n" ];
        key = "<leader>gs";
        lua = true;
        action = "function() Snacks.lazygit() end";
      }
    ];
  };
  vim.extraPackages = [ pkgs.lazygit ];
}
