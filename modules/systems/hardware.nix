{ ... }:

{
  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  zramSwap = {
    enable = true;
    memoryPercent = 50;
    algorithm = "zstd";
  };

  hardware = {
    bluetooth.enable = true;

    graphics = {
      enable = true;
      enable32Bit = true;
    };

    amdgpu = {
      initrd.enable = true;
      opencl.enable = true;
    };
  };
}
