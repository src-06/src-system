{
  flake.nixosModules.lxqt =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        evince
        ffmpegthumbnailer
      ];

      services = {
        gvfs.enable = true;
        xserver.desktopManager.lxqt.enable = true;
      };
    };
}
