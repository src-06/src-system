{
  flake.nixosModules.base =
    { pkgs, ... }:
    {
      fonts = {
        enableDefaultPackages = true;
        fontDir.enable = true;

        fontconfig = {
          enable = true;
          useEmbeddedBitmaps = true;

          defaultFonts = {
            emoji = [ "Noto Color Emoji" ];
            monospace = [ "CaskaydiaMono Nerd Font Mono" ];
            sansSerif = [ "Noto Sans" ];
            serif = [ "Noto Sans" ];
          };
        };

        packages = with pkgs; [
          corefonts
          noto-fonts
          noto-fonts-cjk-sans
          noto-fonts-cjk-serif
          noto-fonts-color-emoji
          nerd-fonts.caskaydia-mono
        ];
      };
    };
}
