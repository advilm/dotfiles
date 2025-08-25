_: {
  services.keyd = {
    enable = true;
    keyboards.default = {
      settings.main.capslock = "overload(meta, esc)";
    };
  };
}
