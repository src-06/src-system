{ self, ... }:
{
  flake.nixosModules.apps =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        faugus-launcher
        prismlauncher
      ];

      programs = {
        gamescope = {
          enable = true;
          capSysNice = true;
        };
        gamemode.enable = true;

        steam = {
          enable = true;
          extraPackages =
            # with pkgs;
            # [
            #   libxcursor
            #   libxi
            #   libxinerama
            #   libxscrnsaver
            #   libpng
            #   libpulseaudio
            #   libvorbis
            #   stdenv.cc.cc.lib
            #   libkrb5
            #   keyutils
            # ]
            # ++
            [
              self.packages.${pkgs.stdenv.hostPlatform.system}.imouto-cursor-theme
            ];
          # localNetworkGameTransfers.openFirewall = true;
        };
      };
    };
}
