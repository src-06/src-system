{
  flake.nixosModules.amd =
    { config, modulesPath, ... }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];

      boot = {
        kernelModules = [
          "kvm-amd"
          "k10temp"
          "v4l2loopback"
        ];

        extraModulePackages = with config.boot.kernelPackages; [
          v4l2loopback
        ];

        tmp.cleanOnBoot = true;

        initrd = {
          availableKernelModules = [
            "xhci_pci"
            "ahci"
            "usb_storage"
            "usbhid"
            "sd_mod"
            "rtsx_pci_sdmmc"
          ];

          kernelModules = [ "amdgpu" ];
        };
      };

      services.xserver.videoDrivers = [ "amdgpu" ];

      hardware = {
        cpu.amd.updateMicrocode = true;

        amdgpu = {
          initrd.enable = true;
          opencl.enable = true;
        };
      };
    };
}
