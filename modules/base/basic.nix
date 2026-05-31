{
  flake.nixosModules.base =
    { pkgs, ... }:
    {
      hardware = {
        bluetooth.enable = true;

        graphics = {
          enable = true;
          enable32Bit = true;
        };
      };

      zramSwap = {
        enable = true;
        algorithm = "zstd";
        memoryPercent = 100;
        priority = 100;
      };

      networking.networkmanager.enable = true;

      time.timeZone = "Asia/Jakarta";
      i18n.defaultLocale = "en_US.UTF-8";

      security.polkit.enable = true;

      services = {
        xserver = {
          enable = true;

          xkb = {
            layout = "us";
            variant = "";
          };
        };

        tuned = {
          enable = true;
          ppdSupport = true;
        };
        upower.enable = true;
        lact.enable = true;
      };

      environment.systemPackages = with pkgs; [
        git
        git-lfs
        gh

        fd
        ripgrep
        fzf

        jq
        yq

        file
        which
        lsof
        strace

        wget
        curl

        imagemagick
        ffmpeg-full

        openssl
        openssh

        fastfetch
        lazygit
      ];
    };
}
