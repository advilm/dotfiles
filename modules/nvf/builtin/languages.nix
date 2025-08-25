_: {
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
}
