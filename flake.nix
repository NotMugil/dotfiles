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
    let 
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in 
    { 
	nixosConfigurations.rei = nixpkgs.lib.nixosSystem {
             specialArgs = {inherit inputs;};
             modules = [
		./hosts/rei/configuration.nix
		inputs.home-manager.nixosModules.default
             ];
          };
    };
}
