{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (writeShellApplication {
      name = "db";
      text = builtins.readFile ./scripts/db.sh;
    })

    mariadb
    postgresql
  ];
}
