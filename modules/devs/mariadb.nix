{
  flake.nixosModules.devs =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        (writeShellApplication {
          name = "mariadb-sh";
          text = builtins.readFile ./scripts/mariadb.sh;
        })
        mariadb
      ];
    };
}
