{pkgs, ...}: {
  vim.formatter.conform-nvim = {
    enable = true;
    setupOpts = {
      formatters_by_ft = {
        nix = ["nixfmt"];
        "*" = [
          "trim_whitespace"
          "trim_newlines"
        ];
      };
      default_format_ops = {
        lsp_format = "fallback";
        async = true;
      };
    };
  };

  vim.keymaps = [
    {
      mode = ["n"];
      key = "<leader>f";
      lua = true;
      action = "function() require('conform').format() end";
    }
  ];

  vim.options.formatexpr = "v:lua.require('conform').formatexpr()";

  vim.extraPackages = [
    pkgs.nixfmt-rfc-style
    pkgs.kdlfmt
  ];
}
