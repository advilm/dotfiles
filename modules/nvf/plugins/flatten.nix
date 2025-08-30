{
  pkgs,
  lib,
  ...
}: {
  vim.lazy.plugins."flatten.nvim" = {
    package = pkgs.vimPlugins.flatten-nvim;
    setupModule = "flatten";
    lazy = false;
    priority = 1001;
    setupOpts = {
      window.open = "current";
      hooks.pipe_path = lib.generators.mkLuaInline ''
        function()
          -- If running in a terminal inside Neovim:
          if vim.env.NVIM then
            return vim.env.NVIM
          end
          -- If running in Alacritty terminal,
          -- all windows with the same ALACRITTY_SOCKET will open in the first neovim instance
          if vim.env.ALACRITTY_SOCKET then
            local addr = ("%s/%s"):format(
              vim.fn.stdpath("run"),
              "alacritty.nvim-" .. vim.fn.fnamemodify(vim.env.ALACRITTY_SOCKET, ":t")
            )

            if not vim.uv.fs_stat(addr) then
              vim.fn.serverstart(addr)
            end
            return addr
          end
        end
      '';
    };
  };
}
