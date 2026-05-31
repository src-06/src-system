{
  flake.nixosModules.plasma =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        kdePackages.kcalc
        kdePackages.filelight
        kdePackages.kcharselect
        haruna
      ];

      programs.kdeconnect.enable = true;

      services.desktopManager.plasma6.enable = true;
    };
}
