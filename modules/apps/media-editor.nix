{
  flake.nixosModules.apps =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        # Vector editor
        drawio
        # inkscape

        # Image editor
        gimp
        pinta

        # Video editor
        shotcut
        # kdePackages.kdenlive

        # Audio editor
        audacity
      ];
    };
}
