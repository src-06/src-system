{ inputs, ... }:
{
  flake.nixosModules.base =
    { pkgs, ... }:
    {
      imports = [
        inputs.nix-index-database.nixosModules.default
      ];

      system.stateVersion = "25.11";

      nixpkgs.config.allowUnfree = true;

      nix.settings = {
        trusted-users = [ "@wheel" ];

        auto-optimise-store = true;
        keep-derivations = false;
        keep-outputs = false;

        experimental-features = [
          "nix-command"
          "flakes"
        ];

        extra-substituters = [
          "https://nix-community.cachix.org"
          "https://noctalia.cachix.org"
        ];

        extra-trusted-public-keys = [
          "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        ];
      };

      programs = {
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };

        nh = {
          enable = true;
          flake = "/home/src-06/.config/NixOS";

          clean = {
            enable = true;
            dates = "daily";
          };
        };

        nix-ld.enable = true;
        nix-index-database.comma.enable = true;
      };

      environment.systemPackages = with pkgs; [
        nil
        nixd
        statix
        nix-tree
      ];
    };
}
