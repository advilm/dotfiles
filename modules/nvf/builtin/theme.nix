{
  pkgs,
  lib,
  ...
}: {
  vim.lazy.plugins."tokyonight.nvim" = {
    package = pkgs.vimPlugins.tokyonight-nvim;
    setupModule = "tokyonight";
    lazy = false;
    priority = 1000;
    setupOpts = {
      on_colors = lib.generators.mkLuaInline ''
        function(colors)
          colors.bg = "#090e15"
        end
      '';
    };
    after = "vim.cmd.colorscheme('tokyonight-night')";
  };
}
