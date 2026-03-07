{ pkgs, ... }:

let
  imouto-cursor-theme = pkgs.stdenv.mkDerivation {
    pname = "imouto-cursor-theme";
    version = "1.0";

    src = pkgs.fetchFromGitHub {
      owner = "src-06";
      repo = "imouto-cursor-theme";
      rev = "v1.0";
      hash = "sha256-vp3XhjfleVfSHvUVT4heyaMEuzpXT2zDFPSHnnhemJI=";
    };

    dontBuild = true;

    installPhase = ''
      mkdir -p $out/share/icons/Imouto
      cp -r $src/. $out/share/icons/Imouto/
    '';
  };

  violet-evergarden-background = pkgs.stdenv.mkDerivation {
    pname = "violet-evergarden-background";
    version = "1.0";

    src = pkgs.fetchFromGitHub {
      owner = "src-06";
      repo = "violet-evergarden-grub-theme";
      rev = "v1.0";
      hash = "sha256-bsQReOqMZMqpgmM2HHfdFCxHyfLaCsJpbDJDaO4cmcM=";
    };

    dontUnpack = true;
    dontBuild = true;

    installPhase = ''
      mkdir -p $out/share/wallpapers
      cp -r $src/background.jpg $out/share/wallpapers/violet-evergarden.jpg
    '';
  };
in
{
  services.xserver.displayManager.lightdm = {
    enable = true;

    greeters.slick = {
      enable = true;

      font = {
        name = "Noto Font 11";
        package = pkgs.noto-fonts;
      };

      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };

      cursorTheme = {
        name = "Imouto";
        package = imouto-cursor-theme;
      };

      draw-user-backgrounds = false;
    };

    background = "${violet-evergarden-background}/share/wallpapers/violet-evergarden.jpg";
  };
}
