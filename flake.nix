{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-generators, ... }@inputs:
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
        ];
      };
      nixosConfigurations.lab-docker = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [ 
          ./hosts/lab-docker/configuration.nix
        ];
      };
      homeConfigurations."joshlee@sting" = inputs.home-manager.lib.homeManagerConfiguration {
        modules = [
          ./homes/joshlee.nix
        ];
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
      };
      homeConfigurations."josh@pop-os" = inputs.home-manager.lib.homeManagerConfiguration {
        modules = [
          ./homes/josh.nix
        ];
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
      };
    };
}
