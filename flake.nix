{
  description = "src-system: flake configurations";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    noctalia-shell = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-unstable,
      home-manager,
      noctalia-shell,
      ...
    }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

      unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };

      commonArgs = {
        username = "src-06";
        hostName = "src-system";
        stateVersion = "25.11";
        homeDirectory =
          if pkgs.stdenv.hostPlatform.isDarwin then
            "/Users/${commonArgs.username}"
          else
            "/home/${commonArgs.username}";
        inherit unstable noctalia-shell;
      };
    in
    {
      nixosConfigurations.${commonArgs.hostName} = nixpkgs.lib.nixosSystem {
        inherit pkgs;
        specialArgs = commonArgs;
        modules = [
          ./modules
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              backupFileExtension = "bak";
              extraSpecialArgs = commonArgs;
              users.${commonArgs.username} = import ./home;
            };
          }
        ];
      };

      # Standalone home-manager
      # homeConfigurations.${commonArgs.username} = home-manager.lib.homeManagerConfiguration {
      #   inherit pkgs;
      #   extraSpecialArgs = commonArgs;
      #   modules = [ ./home ];
      # };
    };
}
