{
  flake.nixosModules.devs =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        php
        phpPackages.composer
      ];
    };
}
