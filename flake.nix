{
  description = "Nix Dotfiles Configuration for macOS and a Future HomeLab";

  inputs = {

    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home manager
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nix Darwin (for MacOS machines)
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      nixpkgs,
      darwin,
      home-manager,
      ...
    }@inputs:
    let

      inherit (self) outputs;

      # Define user configurations
      users = {
        glakos = {
          name = "glakos";
        };
      };

      # Function for NixOS system configuration
      # mkNixosConfiguration = hostname: username:
      #  nixpkgs.lib.nixosSystem {
      #    specialArgs = {
      #      inherit inputs outputs hostname;
      #      userConfig = users.${username};
      #
      #    };
      #    modules = [./hosts/${hostname}];
      #  };

      # Function for nix-darwin system configuration
      mkDarwinConfiguration =
        hostname: username: isCorporate:
        darwin.lib.darwinSystem {
          system = "aarch64-darwin"; # Apple Silicon
          specialArgs = {
            inherit
              inputs
              outputs
              hostname
              isCorporate
              ;
            userConfig = users.${username};
            nixDarwinModules = "${self}/modules/darwin";
          };
          modules = [
            ./hosts/${hostname}
            # home-manager.darwinModules.home-manager
          ];
        };

      # Function for Home Manager configuration
      mkHomeConfiguration = system: hostname: username: isCorporate:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {inherit system;};
          extraSpecialArgs = {
            inherit inputs outputs isCorporate;
            userConfig = users.${username};
            nhModules = "${self}/modules/home-manager";
            dotFiles = "${self}/dotfiles";
          };
          modules = [
            ./home-manager/${hostname}/${username}
          ];
        };
    in
    {
      # nixosConfigurations = {
      # };

      darwinConfigurations = {
        "mac-config" = mkDarwinConfiguration "mac-config" "glakos" false;
      };

      homeConfigurations = {
        "m1-air-personal@glakos" = mkHomeConfiguration "aarch64-darwin" "m1-air-personal" "glakos" false;
      };

    };
}
