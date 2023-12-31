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
      nixosConfigurations.nixos-desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [ 
          ./configuration.nix
          inputs.home-manager.nixosModules.default
        ];
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
      };
      homeConfigurations."joshlee@sting" = inputs.home-manager.lib.homeManagerConfiguration {
        modules = [
          ./users/josh/home.nix
        ];
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
      };
    };
}
