{ pkgs, lib, ... }: {
  vim.utility =  {
    yazi-nvim = {
      enable = true;
      setupOpts = {
        open_for_directories = true;
        integrations.grep_in_directory = "fzf-lua";
        grep_in_selected_files = "fzf-lua";
      };
    };
    
    surround = {
      enable = true;
      useVendoredKeybindings = false;
    };

    mkdir.enable = true;
  };
} 