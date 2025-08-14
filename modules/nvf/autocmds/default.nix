{ lib, ... }:
{
  vim.autocmds = [
    {
      enable = true;
      event = [ "VimEnter" ];
      callback = lib.generators.mkLuaInline ''
        function()
          local arg = vim.fn.expand(vim.fn.argv(0))
          if arg ~= "" and vim.fn.isdirectory(arg) == 1 then
            pcall(vim.api.nvim_set_current_dir, arg)
          elseif vim.fn.bufname("%") ~= "" then
            local dir = vim.fn.expand("%:p:h")
            if dir ~= "" and vim.fn.isdirectory(dir) == 1 then
              pcall(vim.api.nvim_set_current_dir, dir)
            end
          end
        end
      '';
    }
  ];
}
