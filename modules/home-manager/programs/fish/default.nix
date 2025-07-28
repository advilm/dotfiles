{ ... }: {
  programs.fish = {
    enable = true;
    loginShellInit = ''
      if uwsm check may-start
        exec uwsm start default
      end
    ''; # TODO make more general
    interactiveShellInit = ''
      set fish_greeting
    '';
  };
}