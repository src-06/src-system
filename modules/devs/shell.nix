{
  flake.nixosModules.devs =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        shellcheck
      ];
    };
}
