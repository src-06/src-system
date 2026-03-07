{ pkgs, ... }:

{
  virtualisation = {
    libvirtd = {
      enable = true;
      qemu.vhostUserPackages = with pkgs; [ virtiofsd ];
    };
    podman = {
      enable = true;
      dockerCompat = true;
    };
  };
}
