{ self, inputs, ... }:
{
  flake.nixosConfigurations.laptop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.laptopModules
    ];
  };

  flake.nixosModules.laptopModules = {
    imports = with self.nixosModules; [
      base

      ly
      niri

      apps
      devs

      extra-aria2c
      extra-appimage
      extra-flatpak
      extra-virtualbox
    ];

    networking = {
      hostName = "Laptop";

      nameservers = [
        "1.1.1.1"
        "1.0.0.1"
      ];
      networkmanager.dns = "systemd-resolved";

      firewall = {
        enable = true;
        allowPing = true;

        allowedTCPPorts = [
          # 80 # http
          # 443 # https
          3000 # Nuxt, Next.js
          5173 # Vite
          8888 # My custom server port
        ];
      };

      extraHosts = "127.0.0.1 nixos";
    };

    services.resolved = {
      enable = true;

      settings.Resolve = {
        DNSOverTLS = true;
        DNSSEC = "true";
      };
    };
  };
}
