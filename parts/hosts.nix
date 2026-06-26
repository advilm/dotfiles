{
  config,
  inputs,
  withSystem,
  ...
}: let
  inherit (inputs.nixpkgs) lib;

  scanModules = root: let
    walk = dir: let
      entries = builtins.readDir dir;
      childModules =
        lib.foldlAttrs (
          acc: name: type:
            if type == "directory"
            then acc // walk (dir + "/${name}")
            else acc
        ) {}
        entries;
      currentModule =
        if entries ? "default.nix"
        then {
          ${builtins.baseNameOf dir} = dir + "/default.nix";
        }
        else {};
    in
      currentModule // childModules;
  in
    walk root;

  moduleCatalog = {
    nixos = scanModules ../modules/nixos;
    homeManager = scanModules ../modules/home-manager;
  };

  hosts = {
    pc = {
      user = "advil";
      system = "x86_64-linux";
      hardware = [
        ../machines/pc/hardware-configuration.nix
        inputs.nixos-hardware.nixosModules.common-gpu-amd
        inputs.nixos-hardware.nixosModules.common-pc-ssd
      ];
      profile = {
        enableHomeManager = true;
        modules = {
          common = {};
          workstation = {};
          niri = {};
          keyd = {
            useDvorak = true;
          };

          cursor = {};
          fonts = {};
          gtk = {};
          xdg = {};

          alacritty = {};
          anyrun = {};
          evince = {};
          firefox = {};
          fzf = {};
          git = {};
          gpu_screen_recorder = {};
          mpv = {};
          overskride = {};
          signal = {};
          spotify = {};
          discord = {};
          vscode = {};
          yazi = {};
          neovim = {};

          gammastep = {};
          kanshi = {};

          docker = {};
          nautilus = {};
          nh = {};
          obs-studio = {
            enablePlugins = true;
          };
          steam = {};
          virt-manager = {};
          openssh = {};
        };
      };
    };

    framework = {
      user = "advil";
      system = "x86_64-linux";
      hardware = [
        inputs.nixos-hardware.nixosModules.framework-11th-gen-intel
      ];
      profile = {
        enableHomeManager = true;
        modules = {
          common = {};
          workstation = {};
          niri = {};
          keyd = {
            useDvorak = true;
          };

          cursor = {};
          fonts = {};
          gtk = {};
          xdg = {};

          alacritty = {};
          anyrun = {};
          brightnessctl = {};
          evince = {};
          firefox = {};
          fzf = {};
          git = {};
          gpu_screen_recorder = {};
          mpv = {};
          overskride = {};
          signal = {};
          spotify = {};
          discord = {};
          vscode = {};
          yazi = {};
          neovim = {};

          gammastep = {};
          kanshi = {};

          docker = {};
          nautilus = {};
          nh = {};
          obs-studio = {
            enablePlugins = true;
          };
          steam = {};
          virt-manager = {};
          openssh = {};
          tlp = {};
          zerotier = {};
        };
      };
    };

    server = {
      user = "advil";
      system = "x86_64-linux";
      profile = {
        enableHomeManager = true;
        modules = {
          common = {};
          openssh = {};
          keyd = {
            useDvorak = true;
          };
          neovim = {};
        };
      };
    };

    server-micro = {
      user = "advil";
      system = "x86_64-linux";
      profile = {
        enableHomeManager = true;
        modules = {
          common = {
            sudo.wheelNeedsPassword = false;
            networking.useNetworkManager = false;
          };
          openssh = {};
        };
      };
    };
  };

  mkTargetImports = target: moduleConfigs:
    lib.filter (module: module != null)
    (lib.mapAttrsToList (
        name: settings: let
          modulePath = lib.attrByPath [target name] null moduleCatalog;
        in
          if modulePath == null
          then null
          else import modulePath
      )
      moduleConfigs);

  mkHomeImports = hostConfig: mkTargetImports "homeManager" hostConfig.profile.modules;

  mkNixosImports = hostConfig:
    hostConfig.hardware or [] ++ mkTargetImports "nixos" hostConfig.profile.modules;

  mkConfiguration = host: hostConfig: let
    inherit (hostConfig) system user;
    moduleSettings = hostConfig.profile.modules;
    enableHomeManager = hostConfig.profile.enableHomeManager or true;
  in
    withSystem system (
      {self', ...}:
        inputs.nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs host user moduleSettings;
            nixpkgs = inputs.nixpkgs;
            userConfig = config.flake.users.${user};

            customPackages = self'.packages;
          };
          modules =
            [{imports = mkNixosImports hostConfig;}]
            ++ lib.optionals enableHomeManager [
              inputs.home-manager.nixosModules.home-manager
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
                home-manager.users.${user}.imports = (mkHomeImports hostConfig) ++ [../machines/${host}/home.nix];
                home-manager.sharedModules = [
                  inputs.anyrun.homeManagerModules.default
                  ({modulesPath, ...}: {disabledModules = ["${modulesPath}/programs/anyrun.nix"];})
                ];
                home-manager.extraSpecialArgs = {
                  inherit inputs user moduleSettings;
                  userConfig = config.flake.users.${user};

                  customPackages = self'.packages;
                };
              }
            ]
            ++ [
              inputs.nur.modules.nixos.default
              inputs.nix-index-database.nixosModules.nix-index
              inputs.sops-nix.nixosModules.sops
              ../machines/${host}/configuration.nix
            ];
        }
    );
in {
  flake = {
    inherit hosts;
    # Maps flawlessly because mkConfiguration handles its own system switching natively
    nixosConfigurations = lib.mapAttrs mkConfiguration hosts;
  };
}
