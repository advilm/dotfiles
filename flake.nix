{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    hyprland.url = "github:hyprwm/Hyprland";
    
    nix-index-database.url = "github:nix-community/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";

    anyrun.url = "github:anyrun-org/anyrun";
    anyrun.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... } @ inputs : let 
    userConfigs = {
      advil = {
        name = "Adil Mohiuddin";
        email = "adil.mohiuddin07@gmail.com";
        signing_key = "26240A39D41B8ECB";
      };
    };
    mkConfiguration = user: host:
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs nixpkgs host user;
          userConfig = userConfigs.${user};
          nixosModules = "${self}/modules/nixos";
        };
        modules = [
          ./hosts/${host}/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${user} = ./homes/${host}.nix;

            home-manager.extraSpecialArgs = { 
              inherit inputs user;
              userConfig = userConfigs.${user};
              hmModules = "${self}/modules/home-manager";
            };
          }
          inputs.nix-index-database.nixosModules.nix-index
          {environment.systemPackages = [ inputs.anyrun.packages."x86_64-linux".anyrun ];}
        ];
      };
  in {
    nixosConfigurations = {
      pc = mkConfiguration "advil" "pc";
      framework = mkConfiguration "advil" "framework";
    };
  };
}
