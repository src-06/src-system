{
  flake.nixosModules.devs =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        sqlite
        sql-formatter
      ];
    };
}
