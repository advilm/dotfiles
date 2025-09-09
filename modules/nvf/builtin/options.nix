_: {
  vim = {
    viAlias = true;
    vimAlias = true;
    undoFile.enable = true;
    options = {
      scrolloff = 8;
      sidescrolloff = 8;
      tabstop = 4;
      shiftwidth = 4;
      # grepprg = "rg --vimgrep";
    };
    globals = {
      loaded_netrw = 1;
      loaded_netrwPlugin = 1;
    };
  };

  vim.keymaps = [
    {
      mode = ["n" "v"];
      key = "<leader>y";
      action = "\"+y";
    }
    {
      mode = ["n" "v"];
      key = "<leader>Y";
      action = "\"+Y";
    }
    {
      mode = ["n" "v"];
      key = "<leader>p";
      action = "\"+p";
    }
    {
      mode = ["n" "v"];
      key = "<leader>P";
      action = "\"+P";
    }
  ];

  vim.luaConfigPost = ''
    if vim.env.SSH_CONNECTION ~= nil then
      vim.g.clipboard = {
        name = 'OSC 52',
        copy = {
          ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
          ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
        },
        paste = {
          ['+'] = function() return {{}, 'v'} end,
          ['*'] = function() return {{}, 'v'} end,
        },
      }
    end
  '';
}
