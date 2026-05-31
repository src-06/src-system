{
  flake.nixosModules.base =
    { pkgs, ... }:
    {
      users.users."src-06" = {
        isNormalUser = true;
        description = "Violet Evergarden";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        shell = pkgs.fish;
      };

      users.users.root = {
        shell = pkgs.fish;
      };
    };
}
