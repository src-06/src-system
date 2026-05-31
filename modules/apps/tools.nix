{
  flake.nixosModules.apps =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        sql-studio
      ];

      programs = {
        localsend = {
          enable = true;
          openFirewall = true;
        };

        obs-studio.enable = true;
      };
    };
}
