{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    ffmpegthumbnailer
    kdePackages.kdegraphics-thumbnailers
    kdePackages.kate
    kdePackages.filelight
    kdePackages.partitionmanager
    haruna
  ];

  services.desktopManager.plasma6.enable = true;
}
