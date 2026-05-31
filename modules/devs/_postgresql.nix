{
  flake.nixosModules.devs =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        (writeShellApplication {
          name = "pg_sh";
          text = builtins.readFile ./scripts/postgresql.sh;
        })
        postgresql
      ];
    };
}
