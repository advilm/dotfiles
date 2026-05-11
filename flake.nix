{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    anyrun.url = "github:advilm/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.ndg.inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    flake-parts,
    nixpkgs,
    home-manager,
    ...
  }:
    flake-parts.lib.mkFlake { inherit inputs; } (top @ {
      config,
      withSystem,
      ...
    }: let
      userConfigs = {
        advil = {
          name = "Adil Mohiuddin";
          email = "git@adilm.net";
          signing_key = "1FFF29A19DFE8EBF";
        };
      };
      # Construct self.packages for home-manager modules (e.g. niri) that need self.packages.${system}.*
      selfPackages = {
        x86_64-linux = withSystem "x86_64-linux" ({ config, ... }: config.packages);
        aarch64-linux = withSystem "aarch64-linux" ({ config, ... }: config.packages);
        aarch64-darwin = withSystem "aarch64-darwin" ({ config, ... }: config.packages);
      };
      mkConfiguration = user: host: system:
        nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs nixpkgs host user;
            userConfig = userConfigs.${user};
            nixosModules = "${./.}/modules/nixos";
          };
          modules = [
            ./machines/${host}/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${user} = ./machines/${host}/home.nix;

              home-manager.sharedModules = [
                # Import anyrun's flake home-manager module, disable existing module
                inputs.anyrun.homeManagerModules.default
                ({modulesPath, ...}: {
                  disabledModules = ["${modulesPath}/programs/anyrun.nix"];
                })

                {home.packages = [(withSystem "x86_64-linux" ({ config, ... }: config.packages.neovim))];}
              ];

              home-manager.extraSpecialArgs = {
                self = { packages = selfPackages; };
                inherit inputs user;
                userConfig = userConfigs.${user};
                hmModules = "${./.}/modules/home-manager";
              };
            }

            inputs.nur.modules.nixos.default
            inputs.nix-index-database.nixosModules.nix-index
          ];
        };
    in {
      systems = ["x86_64-linux" "aarch64-linux" "aarch64-darwin"];

      perSystem = { config, pkgs, system, ... }: {
        packages = let
          mkNvfConfiguration =
            inputs.nvf.lib.neovimConfiguration {
              inherit pkgs;
              modules = [./modules/nvf];
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

      flake.nixosConfigurations = {
        pc = mkConfiguration "advil" "pc" "x86_64-linux";
        framework = mkConfiguration "advil" "framework" "x86_64-linux";
      };
    });
}
