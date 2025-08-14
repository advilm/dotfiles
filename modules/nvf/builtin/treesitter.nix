{ pkgs, ... }:
{
  vim.treesitter = {
    textobjects = {
      enable = true;
      setupOpts.select = {
        enable = true;
        lookahead = true;
        keymaps = {
          "a=" = "@assignment.outer";
          "i=" = "@assignment.inner";
          "l=" = "@assignment.lhs";
          "r=" = "@assignment.rhs";

          "aa" = "@parameter.outer";
          "ia" = "@parameter.inner";

          "ai" = "@conditional.outer";
          "ii" = "@conditional.inner";

          "al" = "@loop.outer";
          "il" = "@loop.inner";

          "ae" = "@call.outer";
          "ie" = "@call.inner";

          "af" = "@function.outer";
          "if" = "@function.inner";

          "ac" = "@class.outer";
          "ic" = "@class.inner";
        };
      };
    };
    autotagHtml = true;
    grammars = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      typescript
    ];
    context.enable = true;
    context.setupOpts.separator = null;
  };
}
