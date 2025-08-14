_: {
  vim.formatter.conform-nvim = {
    enable = true;
    setupOpts = {
      formatters_by_ft = {
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
}
