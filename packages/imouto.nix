{
  perSystem =
    { pkgs, ... }:
    {
      packages.imouto-cursor-theme = pkgs.stdenvNoCC.mkDerivation {
        pname = "imouto-cursor-theme";
        version = "1.0";

        src = pkgs.fetchFromGitHub {
          owner = "src-06";
          repo = "imouto-cursor-theme";
          rev = "1f55d180e0dfecc4fe0cd0e5875b2ae94c84adde";
          hash = "sha256-/lxeZpF3Y1+vsvVfXPk696boJr8RCZr0+kQEuoT4TBY=";
        };

        dontBuild = true;

        installPhase = ''
          mkdir -p $out/share/icons/Imouto $out/share/icons/default
          cp -r $src/. $out/share/icons/Imouto/

          cat > $out/share/icons/default/index.theme <<EOF
            [Icon Theme]
            Inherits=Imouto
          EOF
        '';
      };
    };
}
