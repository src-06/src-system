{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      git
      gh
      wget
      rsync
      tree
      unrar
      dnsmasq
      distrobox
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    };
  };
}
