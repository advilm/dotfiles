{ pkgs, ... }:
{
  vim.lazy.plugins."auto-session" = {
    package = pkgs.vimPlugins.auto-session;
    setupModule = "auto-session";
    lazy = false;
    setupOpts = {
      suppressed_dirs = [ "~" ];
    };
    before = ''
      local arg = vim.fn.expand(vim.fn.argv(0))
      if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
        pcall(vim.api.nvim_set_current_dir, arg)
      elseif vim.fn.bufname("%") ~= "" then
        local dir = vim.fn.expand("%:p:h")
        if dir ~= "" and vim.fn.isdirectory(dir) == 1 then
          pcall(vim.api.nvim_set_current_dir, dir)
        end
      end
    '';
    after = ''
      vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
    '';
  };
}
