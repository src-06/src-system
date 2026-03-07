{ unstable, ... }:

{
  imports = [
    ./bun.nix
    ./cpp.nix
    ./db.nix
    ./nix.nix
    ./node.nix
    ./php.nix
    ./py.nix
    ./shell.nix
  ];

  home.packages = with unstable; [
    # Manage databases
    antares

    # AI Agent on terminal
    opencode
    gemini-cli
  ];
}
