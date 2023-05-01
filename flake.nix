{
  description = "irishgreencitrus' NixOS configuration";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
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
      };
      sourkraut = nixpkgs.lib.nixosSystem {
        system = systemVersion;
        modules = [
          ./systems/sourkraut/configuration.nix
        ];
      };
    };
  };
}
