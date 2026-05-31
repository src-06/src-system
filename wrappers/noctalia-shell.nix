{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.noctalia-shell = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
        inherit pkgs;
        package = inputs.noctalia-shell.packages.${pkgs.stdenv.hostPlatform.system}.default;

        # I'm tired, next time maybe I'll add Noctalia settings..
      };
    };
}
