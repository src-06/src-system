{
  flake.nixosModules.apps =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        gemini-cli
        opencode
      ];
    };
}
