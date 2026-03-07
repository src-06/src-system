{ unstable, ... }:

{
  home.packages = with unstable; [
    nil
    # niv
    nixd
    nixfmt
    # statix
  ];
}
