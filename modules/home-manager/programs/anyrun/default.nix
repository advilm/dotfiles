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
        inputs.anyrun.packages.${pkgs.system}.rink
        inputs.anyrun.packages.${pkgs.system}.nix-run
      ];
    };

    extraCss = ''
      window {
        background: transparent;
      }

      box.main {
        padding: 5px;
        margin: 10px;
        border: 2px solid @theme_selected_bg_color;
        background-color: @theme_bg_color;
        box-shadow: 0 0 5px black;
      }

      text {
        font-size: 20px;
        min-height: 30px;
        padding: 5px;
        border-radius: 5px;
      }

      .matches {
        background-color: rgba(0, 0, 0, 0);
      }

      list.plugin {
        background-color: rgba(0, 0, 0, 0);
      }

      list.plugin row {
        margin-top: 2px;
        margin-left: 12px;
        background: transparent;
      }

      list.plugin row:selected {
        border-left: 2px solid @theme_selected_bg_color;
        margin-left: 4px;
        padding-left: 6px;
        background: @theme_bg_color;
      }

      list.plugin row:first-child {
        margin-top: 0px;
      }

      label.match.title {
        font-size: 20px;
      }

      label.match.description {
        font-size: 16px;
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
