{ pkgs, lib, ... }:
{
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
      # {
      #   mode = "v";
      #   key = "<leader>y";
      #   lua = true;
      #   action = "function() require('osc52').copy_visual() end";
      # }
    ];
  };

  vim.autocmds = [
    {
      enable = true;
      event = [ "TextYankPost" ];
      callback = lib.generators.mkLuaInline ''
        function()
          if vim.v.event.operator == 'y' and vim.v.event.regname == '+' then
            require('osc52').copy_register('+')
          end
        end
      '';
    }
  ];
}
