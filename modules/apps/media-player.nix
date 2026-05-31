{
  flake.nixosModules.apps =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        mpv
        audacious
      ];
    };
}
