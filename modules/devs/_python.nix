{
  flake.nixosModules.devs =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        python313
        python313Packages.pipx
        python313Packages.black
        python313Packages.ruff
        basedpyright
      ];
    };
}
