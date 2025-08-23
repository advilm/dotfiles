_:
{
  vim.lsp.enable = true;
  vim.lsp.otter-nvim.enable = true;

  vim.autocomplete.blink-cmp = {
    enable = true;
    setupOpts = {
      fuzzy.implementation = "rust";
      cmdline.keymap.preset = "default";
    };
  };
}
