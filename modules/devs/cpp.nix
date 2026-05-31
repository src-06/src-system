{
  flake.nixosModules.devs =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        clang-tools
        gcc
      ];
    };
}
