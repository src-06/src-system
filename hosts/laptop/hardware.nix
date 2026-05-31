{ self, ... }:
{
  flake.nixosModules.laptopModules =
    { pkgs, ... }:
    {
      imports = [
        /etc/nixos/hardware-configuration.nix
        self.nixosModules.amd
      ];

      nixpkgs.hostPlatform = "x86_64-linux";

      boot = {
        kernelPackages = pkgs.linuxPackages_latest;

        # kernelParams = [
        #   "quiet"
        #   "splash"
        # ];

        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
        };
      };
    };
}
