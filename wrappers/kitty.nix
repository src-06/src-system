{ inputs, ... }:
{
  perSystem =
    { pkgs, ... }:
    {
      packages.kitty = inputs.wrapper-modules.wrappers.kitty.wrap {
        inherit pkgs;

        font.size = 11;
        font.name = "CaskaydiaMono Nerd Font Mono";

        settings = {
          cursor_shape = "beam";
          cursor_trail = 3;

          background_opacity = 0.85;

          window_margin_width = "8.0 10.0";

          remember_window_size = false;
          initial_window_width = 960;
          initial_window_height = 480;

          confirm_os_window_close = 0;
        };
      };
    };
}
