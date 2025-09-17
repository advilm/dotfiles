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
      width.absolute = 400;
      hideIcons = false;
      ignoreExclusiveZones = true;
      layer = "overlay";
      hidePluginInfo = true;
      closeOnClick = true;
      showResultsImmediately = true;
      maxEntries = 5;

      plugins = [
        inputs.anyrun.packages.${pkgs.system}.applications
        inputs.anyrun.packages.${pkgs.system}.powermenu
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
      }

      text {
        font-size: 18px;
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
        margin-bottom: 4px;
        margin-left: 12px;
        background: transparent;
      }

      list.plugin row:selected {
        border-left: 2px solid @theme_selected_bg_color;
        margin-left: 4px;
        padding-left: 6px;
        background: @theme_bg_color;
      }

      label.match.title {
        font-size: 18px;
      }

      label.match.description {
        font-size: 12px;
      }
    '';
    extraConfigFiles = {
      "applications.ron".text = ''
        Config(
          hide_descriptions: true,
        )
      '';
      "powermenu.ron".text = ''
        Config(
          prefix: ":sys",
        )
      '';
      "rink.ron".text = ''
        Config(
          prefix: "=",
        )
      '';
      "nix-run.ron".text = ''
        Config(
          prefix: ":nr",
          allow_unfree: true,
          channel: "nixpkgs-unstable",
          max_entries: 5,
        )
      '';
    };
  };
}
