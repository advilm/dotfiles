{
  pkgs,
  lib,
  ...
}: {
  vim.lazy.plugins."snacks.nvim" = {
    package = pkgs.vimPlugins.snacks-nvim;
    setupModule = "snacks";
    lazy = false;
    setupOpts = {
      dashboard = {
        sections = [
          {
            title = "neovim";
            align = "center";
            padding = 1;
          }
          {
            pane = 1;
            icon = " ";
            title = "Projects";
            section = "projects";
            indent = 2;
            padding = 1;
            dirs = lib.generators.mkLuaInline ''
              function()
                root_dir = require("auto-session.config").root_dir
                sessions = require("auto-session.lib").get_session_list(root_dir)

                local session_names = vim.tbl_map(function(session)
                  return session.session_name
                end, sessions)

                return session_names
              end
            '';
            action = lib.generators.mkLuaInline ''
              function(session_name)
                require("auto-session").RestoreSession(session_name)
              end
            '';
          }
          {
            pane = 1;
            icon = " ";
            title = "Recent Files";
            section = "recent_files";
            indent = 2;
            padding = 1;
          }
          # keys
          {
            icon = " ";
            key = "q";
            desc = "Quit";
            action = ":qa";
          }
          {
            icon = " ";
            key = "s";
            desc = "Search Sessions";
            action = ":SessionSearch";
          }
        ];
      };
    };
    keys = [
      {
        mode = ["n"];
        key = "<leader>gs";
        lua = true;
        action = "function() Snacks.lazygit() end";
      }
    ];
  };
  vim.extraPackages = [pkgs.lazygit];
}
