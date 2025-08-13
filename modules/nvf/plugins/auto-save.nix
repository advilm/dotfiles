{ pkgs, lib, ... }: {
  vim.lazy.plugins."auto-save.nvim" = {
    package = pkgs.vimPlugins.auto-save-nvim;
    setupModule = "auto-save";
    cmd = "ASToggle";
    event = [ "InsertLeave" "TextChanged" ];
  };
} 