{ self, ... }:
{
  flake.nixosModules.niri =
    { pkgs, ... }:
    let
      selfpkgs = self.packages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      environment.systemPackages =
        with pkgs;
        [
          papirus-nord
          qt6Packages.qt6ct
          nwg-look

          zip
          unzip
          p7zip
          gnutar
          gzip
          lzip
          lz4
          xz
          zstd
          bzip2
          unrar
          xarchiver

          pywalfox-native
          wl-mirror
        ]
        ++ (with selfpkgs; [
          imouto-cursor-theme

          kitty
          imv
          zathura

          noctalia-shell
        ]);

      programs = {
        xfconf.enable = true;
        thunar = {
          enable = true;
          plugins = with pkgs; [
            (thunar-archive-plugin.overrideAttrs (old: {
              postInstall = (old.postInstall or "") + ''
                install -Dm755 ${pkgs.xarchiver}/libexec/thunar-archive-plugin/xarchiver.tap $out/libexec/thunar-archive-plugin/xarchiver.tap
              '';
            }))
          ];
        };

        niri = {
          enable = true;
          useNautilus = false;
          package = selfpkgs.niri;
        };
      };

      services = {
        libinput.enable = true;
        gvfs.enable = true;
        tumbler.enable = true;
      };
    };
}
