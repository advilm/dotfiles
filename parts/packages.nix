{inputs, ...}: {
  perSystem = {pkgs, ...}: {
    packages = let
      mkNvfConfiguration = inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [../modules/nvf];
      };
    in {
      inherit (mkNvfConfiguration) neovim;
      notify-call = pkgs.rustPlatform.buildRustPackage {
        pname = "notify-call";
        version = "0.1.1";
        nativeBuildInputs = [pkgs.pkg-config];
        buildInputs = [pkgs.dbus];

        src = pkgs.fetchFromGitHub {
          owner = "crabvk";
          repo = "notify-call";
          rev = "4c3974bded3e709d0a09cb7e17c099604c8d7cdc";
          hash = "sha256-6oUFA++M6O0snqMa7r/T3oAMG/uW39bv2hXDRvV1NrY=";
        };
        cargoHash = "sha256-bebWiK77YHJhRfe0tikdPrc6hAbrzzUXYWFMLN3P5j4=";
        doCheck = false;
        meta.mainProgram = "notify-call";
      };
    };

    formatter = pkgs.writeShellApplication {
      name = "nix3-fmt-wrapper";

      runtimeInputs = [
        pkgs.alejandra
        pkgs.fd
      ];

      text = ''
        # Find Nix files in the tree and format them with Alejandra
        fd "$@" -t f -e nix -x alejandra -q '{}'
      '';
    };
  };
}
