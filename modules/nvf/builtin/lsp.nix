{pkgs, ...}: {
  vim.lsp.enable = true;
  vim.lsp.otter-nvim.enable = true;

  vim.languages = {
    enableTreesitter = true;
    enableFormat = true;
    enableExtraDiagnostics = true;
    enableDAP = true;

    nix.enable = true;
    markdown.enable = true;
    bash.enable = true;
    clang.enable = true;
    css.enable = true;
    html.enable = true;
    sql.enable = true;
    java.enable = true;
    ts.enable = true;
    lua.enable = true;
    python.enable = true;
    typst.enable = true;
    rust = {
      enable = true;
      crates.enable = true;
    };
    tailwind.enable = true;
  };

  vim.autocomplete.blink-cmp = {
    enable = true;
    setupOpts = {
      keymap = {
        preset = "none";
        "<C-space>" = ["show" "show_documentation" "hide_documentation"];

        "<C-e>" = ["hide"];
        "<C-y>" = ["select_and_accept"];

        "<C-p>" = ["select_prev"];
        "<C-n>" = ["select_next"];

        "<C-b>" = ["scroll_documentation_up"];
        "<C-f>" = ["scroll_documentation_down"];

        "<C-k>" = ["show_signature" "hide_signature"];
      };
      cmdline.keymap = {
        "<C-space>" = ["show" "show_documentation" "hide_documentation"];
        "<Tab>" = ["show_and_insert" "select_next"];
        "<S-Tab>" = ["show_and_insert" "select_prev"];

        "<C-e>" = ["hide"];
        "<C-y>" = ["select_and_accept"];

        "<C-p>" = ["select_prev"];
        "<C-n>" = ["select_next"];

        "<C-b>" = ["scroll_documentation_up"];
        "<C-f>" = ["scroll_documentation_down"];

        "<C-k>" = ["show_signature" "hide_signature"];
      };
    };
    mappings = {
      close = null;
      complete = null;
      confirm = null;
      next = null;
      previous = null;
      scrollDocsDown = null;
      scrollDocsUp = null;
    };
  };
}
