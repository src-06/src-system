{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.zathura = inputs.wrapper-modules.wrappers.zathura.wrap {
        inherit pkgs;

        runtimePkgs = [
          pkgs.wl-clipboard
        ];

        settings = {
          selection-clipboard = "clipboard";
        };

        plugins = with pkgs.zathuraPkgs; [
          zathura_cb # Comic Book supoort.
          zathura_pdf_mupdf # PDF support.
        ];
      };
    };
}
