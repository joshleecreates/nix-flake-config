{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-generators, ... }@inputs:
    {
      packages.x86_64-linux = {
        vm = nixos-generators.nixosGenerate {
          system = "x86_64-linux";
          modules = [
            ./hosts/vm/configuration.nix
            ./hosts/vm/iso.nix
          ];
          format = "proxmox";
        };
      };
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
      nixosConfigurations.okvir = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [ 
          ./hosts/okvir/configuration.nix
        ];
      };
      homeConfigurations."joshlee@sting" = inputs.home-manager.lib.homeManagerConfiguration {
        modules = [
          ./users/josh/home.nix
        ];
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
      };
    };
}
