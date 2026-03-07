{ ... }:

{
  imports = [
    ./systems
    # ./desktop/lxqt.nix
    ./desktop/plasma.nix
    ./manager/lightdm.nix
    # ./manager/sddm.nix
    ./window/niri.nix
  ];
}
