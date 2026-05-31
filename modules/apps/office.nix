{
  flake.nixosModules.apps =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        onlyoffice-desktopeditors
      ];
    };
}
