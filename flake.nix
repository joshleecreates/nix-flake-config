{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    {
      nixosConfigurations.kasti = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [ 
          ./hosts/kasti/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      nixosConfigurations.oko = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [ 
          ./hosts/oko/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      homeConfigurations."joshlee@sting" = inputs.home-manager.lib.homeManagerConfiguration {
        modules = [
          ./users/josh/home.nix
        ];
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
      };
      nixosConfigurations.nixos-server = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [
          ./server-configuration.nix
        ];
      };
    };
}
