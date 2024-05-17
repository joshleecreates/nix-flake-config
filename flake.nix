{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-24.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    # Optional: Declarative tap management
    homebrew-core = {
      url = "github:homebrew/homebrew-core";
      flake = false;
    };
    homebrew-cask = {
      url = "github:homebrew/homebrew-cask";
      flake = false;
    };
    homebrew-bundle = {
      url = "github:homebrew/homebrew-bundle";
      flake = false;
    };
    homebrew-felixkratz = {
      url = "github:FelixKratz/homebrew-formulae";
      flake = false;
    };
  };

  outputs = { self, nixpkgs, home-manager, darwin, homebrew-felixkratz, homebrew-core, homebrew-cask, homebrew-bundle, ... }@inputs:
    {
      nixosConfigurations.kasti = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        system = "x86_64-linux";
        modules = [ 
          ./hosts/kasti/configuration.nix
          inputs.home-manager.nixosModules.default
        ];
      };
      homeConfigurations."joshlee@sting" = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./homes/joshlee.nix
        ];
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
      };
      homeConfigurations."josh@pop-os" = home-manager.lib.homeManagerConfiguration {
        modules = [
          ./homes/josh.nix
        ];
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
      };
      darwinConfigurations."sting" = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          home-manager.darwinModules.home-manager
          inputs.nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                user = "joshlee";
                enable = true;
                taps = {
                  "homebrew/homebrew-core" = homebrew-core;
                  "homebrew/homebrew-cask" = homebrew-cask;
                  "homebrew/homebrew-bundle" = homebrew-bundle;
                  "felixkratz/homebrew-formulae" = homebrew-felixkratz;
                };
                mutableTaps = true;
                autoMigrate = true;
              };
            }
          ./hosts/macbook/configuration.nix
        ];
      };
    };
}
