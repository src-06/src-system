{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    evince
    # ffmpegthumbnailer
    gvfs
  ];

  services.xserver.desktopManager.lxqt.enable = true;
}
