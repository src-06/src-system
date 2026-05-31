{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.imv = inputs.wrapper-modules.wrappers.imv.wrap {
        inherit pkgs;
        runtimePkgs = with pkgs; [
          farbfeld # Suckless image format.
          libtiff # TIFF support.
          libpng # PNG support.
          libjpeg_turbo # JPEG support.
          librsvg # SVG support.
          libnsgif # Animated GIF support.
          libnsbmp # BMP support.
          libheif # HEIF support.
          libjxl # JPEGXL support.
          libwebp # WebP supprt.
          qoi # QOI support.
        ];
      };
    };
}
