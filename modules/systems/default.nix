{ stateVersion, ... }:

{
  imports = [
    ./shell
    ./boot.nix
    ./fonts.nix
    ./hardware.nix
    ./networking.nix
    ./packages.nix
    ./programs.nix
    ./services.nix
    ./users.nix
    ./virtualization.nix
  ];

  system = { inherit stateVersion; };

  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  security.rtkit.enable = true;
}
