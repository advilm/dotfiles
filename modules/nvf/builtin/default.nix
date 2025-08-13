{ pkgs, lib, ... }: {
  imports = [
    ./comments.nix
    ./formatter.nix
    ./languages.nix
    ./lsp.nix
    ./mini.nix
    ./options.nix
    ./theme.nix
    ./treesitter.nix
    ./ui.nix
    ./utility.nix
    ./visuals.nix
  ];
} 