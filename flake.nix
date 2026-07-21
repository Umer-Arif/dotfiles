  {
    description = "Omer's Unstable NixOS Flake Configuration";

    inputs = {
      # Uses the absolute latest bleeding-edge packages
      nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
      
      mangowm = {
      url = "github:mangowm/mango";
      inputs.nixpkgs.follows = "nixpkgs";
      };

      # Track the matching unstable branch for Home Manager
      home-manager.url = "github:nix-community/home-manager";
      home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = { self, nixpkgs, home-manager, ... }@inputs: {
      nixosConfigurations = {
        # Matches your computer's hostname
        omer = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";

          specialArgs = { inherit inputs; };


          modules = [
            ./hardware-configuration.nix
            ./configuration.nix

            # Inject Home Manager module directly into the system build
            # Inject Home Manager module directly into the system build
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
             
              # Map Home Manager configuration strictly to your REAL username
              home-manager.users.omer = import ./home.nix;
            }
          ];
        };
      };
    };
  }
