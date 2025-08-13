{ pkgs, lib, ... }: {
  imports = [
    ./builtin
    ./plugins
    ./autocmds
  ];
}
