{ pkgs, ... }:
{
  vim.utility = {
    yazi-nvim = {
      enable = true;
      setupOpts = {
        integrations.grep_in_directory = "fzf-lua";
        grep_in_selected_files = "fzf-lua";
      };
    };
    surround = {
      enable = true;
      useVendoredKeybindings = false;
    };
    mkdir.enable = true;
    vim-wakatime.enable = true;
    diffview-nvim.enable = true;
  };

  vim.git.gitsigns.enable = true;

  vim.autopairs.nvim-autopairs = {
    enable = true;
    setupOpts.check_ts = true;
  };

  vim.extraPackages = [ pkgs.yazi ];
}
