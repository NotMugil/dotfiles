{
  description = "NotMugil's dotfiles flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      type = "github";
      owner = "nix-community";
      repo = "home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    { 
	nixosConfigurations = { 
	  rei = let 
            system = "x86_64-linux";
            username = "rei";
            specialArgs = {inherit username;};
            pkgs = nixpkgs.legacyPackages.${system};
          in
	   nixpkgs.lib.nixosSystem {
              specialArgs = {inherit username inputs;};
              modules = [
	 	 ./hosts/${username}/configuration.nix

		 home-manager.nixosModules.home-manager {
		   home-manager.useGlobalPkgs = true;
                   home-manager.useUserPackages = true;
		   home-manager.extraSpecialArgs = inputs // specialArgs;
 		   home-manager.users.${username} = import ./hosts/${username}/home.nix;
		 }
              ];
           };
         };
    };
}
