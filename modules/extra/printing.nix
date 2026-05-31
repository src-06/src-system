{
  flake.nixosModules.extra-printing =
    { pkgs, ... }:
    {
      services.printing = {
        enable = true;

        drivers = with pkgs; [
          cnijfilter2
          gutenprint
        ];
      };

      environment.systemPackages = [
        pkgs.simple-scan
      ];
    };
}
