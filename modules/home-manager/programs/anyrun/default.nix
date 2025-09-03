{
  inputs,
  pkgs,
  ...
}: {
  programs.anyrun = {
    enable = true;
    package = inputs.anyrun.packages.${pkgs.system}.anyrun;
    config = {
      x.fraction = 0.5;
      y.fraction = 0.4;
      width.fraction = 0.25;
      hideIcons = false;
      ignoreExclusiveZones = true;
      layer = "overlay";
      hidePluginInfo = true;
      closeOnClick = true;
      showResultsImmediately = true;
      maxEntries = 5;

      plugins = [
        inputs.anyrun.packages.${pkgs.system}.applications
        inputs.anyrun.packages.${pkgs.system}.nix-run
      ];
    };

    # Inline comments are supported for language injection into
    # multi-line strings with Treesitter! (Depends on your editor)
    extraCss = ''
      #window {
        background: transparent;
      }
    '';

    extraConfigFiles."nix-run.ron".text = ''
      Config(
        prefix: ":nr",
        allow_unfree: true,
        channel: "nixpkgs-unstable",
        max_entries: 5,
      )
    '';
  };
}
