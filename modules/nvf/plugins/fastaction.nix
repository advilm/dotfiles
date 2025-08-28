{ pkgs, ... }:
{
  vim.lazy.plugins."fastaction.nvim" = {
    package = pkgs.vimUtils.buildVimPlugin {
      pname = "fastaction.nvim";
      version = "v2.0.1";
      src = pkgs.fetchFromGitHub {
        owner = "advilm";
        repo = "fastaction.nvim";
        rev = "6a57f4dbcb328f10d0c393303a2571893f6626c4";
        sha256 = "sha256-va00sqM2Ap9faUXww5CpWJQyCixN9fIwh8p8oSLQMy8=";
      };
    };
    setupModule = "fastaction";
    setupOpts = {
      popup = {
        relative = "cursor";
        title = "";
      };
      register_ui_select = false;
    };
    keys = [
      {
        mode = [ "n" ];
        key = "<leader>ca";
        lua = true;
        action = "function()
          require('fastaction').code_action()
        end";
      }
    ];
  };
}
