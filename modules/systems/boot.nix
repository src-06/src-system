{ pkgs, ... }:

let
  violet-evergarden-grub-theme = pkgs.stdenv.mkDerivation {
    pname = "violet-evergarden-grub-theme";
    version = "1.0";

    src = pkgs.fetchFromGitHub {
      owner = "src-06";
      repo = "violet-evergarden-grub-theme";
      rev = "v1.0";
      hash = "sha256-bsQReOqMZMqpgmM2HHfdFCxHyfLaCsJpbDJDaO4cmcM=";
    };

    dontBuild = true;

    installPhase = ''
      mkdir -p $out
      cp -r $src/. $out/
    '';
  };
in
{
  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = false;

      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        theme = violet-evergarden-grub-theme;
        extraConfig = ''
          set gfxpayload=keep
        '';
      };

      efi.canTouchEfiVariables = true;
    };
  };
}
