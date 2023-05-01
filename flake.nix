{
  description = "irishgreencitrus' NixOS configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    nixpkgs-unstable.url = "nixpkgs/nixos-unstable";
    zest.url = "github:irishgreencitrus/zest";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    zest
  }: let
    systemVersion = "x86_64-linux";
    username = "lime";
    stateVersion = "22.11";
  in {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
    nixosConfigurations = {
      pomegranate = nixpkgs.lib.nixosSystem {
        system = systemVersion;
        modules = [
          ./systems/pomegranate/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.users.${username} = import ./shared/home_manager/configuration.nix {
              inherit stateVersion systemVersion username;
            };
          }
        ];
        specialArgs = {
            unstable-pkgs = nixpkgs-unstable.legacyPackages."${systemVersion}".pkgs;
            zest-pkgs = zest.packages.${systemVersion};
        }; 
      };
      sauerkraut = nixpkgs.lib.nixosSystem {
        system = systemVersion;
        modules = [
          ./systems/sauerkraut/configuration.nix
        ];
      };
    };
  };
}
