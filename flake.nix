{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixos-hardware.url = "github:nixos/nixos-hardware";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    anyrun.url = "github:anyrun-org/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";

    nvf.url = "github:notashelf/nvf";
    nvf.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    userConfigs = {
      advil = {
        name = "Adil Mohiuddin";
        email = "adil.mohiuddin07@gmail.com";
        signing_key = "26240A39D41B8ECB";
      };
    };
    mkConfiguration = user: host: system:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit self inputs nixpkgs host user;
          userConfig = userConfigs.${user};
          nixosModules = "${self}/modules/nixos";
        };
        modules = [
          ./machines/${host}/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = ./machines/${host}/home.nix;

            home-manager.extraSpecialArgs = {
              inherit self inputs user;
              userConfig = userConfigs.${user};
              hmModules = "${self}/modules/home-manager";
            };
          }
          inputs.nur.modules.nixos.default
          inputs.nix-index-database.nixosModules.nix-index
          {
            # flake packages
            environment.systemPackages = [
              inputs.anyrun.packages.${system}.anyrun
              self.packages.${system}.neovim
            ];
          }
        ];
      };

    mkSystemPackages = systems: f:
      builtins.listToAttrs (
        map (system: {
          name = system;
          value = f system;
        })
        systems
      );

    mkNvfConfiguration = system:
      inputs.nvf.lib.neovimConfiguration {
        pkgs = import nixpkgs {inherit system;};
        modules = [
          ./modules/nvf
        ];
      };
  in {
    nixosConfigurations = {
      pc = mkConfiguration "advil" "pc" "x86_64-linux";
      framework = mkConfiguration "advil" "framework" "x86_64-linux";
    };

    formatter = mkSystemPackages ["x86_64-linux" "aarch64-linux" "aarch64-darwin"] (
      system: let
        pkgs = import nixpkgs {inherit system;};
      in
        pkgs.writeShellApplication {
          name = "nix3-fmt-wrapper";

          runtimeInputs = [
            pkgs.alejandra
            pkgs.fd
          ];

          text = ''
            # Find Nix files in the tree and format them with Alejandra
            fd "$@" -t f -e nix -x alejandra -q '{}'
          '';
        }
    );

    packages = mkSystemPackages ["x86_64-linux" "aarch64-linux" "aarch64-darwin"] (system: let
      pkgs = import nixpkgs {inherit system;};
    in {
      inherit (mkNvfConfiguration system) neovim;
      notify-call = pkgs.rustPlatform.buildRustPackage {
        pname = "notify-call";
        version = "0.1.1";
        nativeBuildInputs = [ pkgs.pkg-config ];
        buildInputs = [ pkgs.dbus ];
        src = pkgs.fetchFromGitHub {
          owner = "crabvk";
          repo = "notify-call";
          rev = "4c3974bded3e709d0a09cb7e17c099604c8d7cdc";
          hash = "sha256-6oUFA++M6O0snqMa7r/T3oAMG/uW39bv2hXDRvV1NrY=";
        };
        cargoHash = "sha256-bebWiK77YHJhRfe0tikdPrc6hAbrzzUXYWFMLN3P5j4=";
        doCheck = false;
      };
    });
  };
}
