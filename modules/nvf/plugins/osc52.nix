{
  pkgs,
  lib,
  ...
}: let
  copy = lib.generators.mkLuaInline "
    function(lines, _)
      require('osc52').copy(table.concat(lines, '\\n'))
    end
  ";
  paste = lib.generators.mkLuaInline "
    function()
      return {vim.fn.split(vim.fn.getreg(''), '\\n'), vim.fn.getregtype('')}
    end
  ";
in {
  vim.lazy.plugins."nvim-osc52" = {
    package = pkgs.vimPlugins.nvim-osc52;
    lazy = false;
    keys = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>y";
        action = "\"+y";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>p";
        action = "\"+p";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>P";
        action = "\"+P";
      }
    ];
  };

  vim.globals.clipboard = {
    name = "osc52";
    copy = {
      "+" = copy;
      "*" = copy;
    };
    paste = {
      "+" = paste;
      "*" = paste;
    };
  };
}
