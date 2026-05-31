{ inputs, ... }:
{
  perSystem =
    { pkgs, lib, ... }:
    {
      packages.niri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;

        settings = {
          spawn-at-startup = [
            "noctalia-shell"
          ];

          prefer-no-csd = _: { };
          screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

          environment = {
            QT_QPA_PLATFORM = "wayland";
            QT_QPA_PLATFORMTHEME = "qt6ct";

            NIXOS_OZONE_WL = "1";
            ELECTRON_OZONE_PLATFORM_HINT = "wayland";
            PROTON_ENABLE_WAYLAND = "1";

            WLR_NO_HARDWARE_CURSORS = "1";
          };

          hotkey-overlay = {
            skip-at-startup = _: { };
            hide-not-bound = _: { };
          };

          cursor = {
            xcursor-theme = "Imouto";
            xcursor-size = 24;

            hide-when-typing = _: { };
            hide-after-inactive-ms = 5000;
          };

          xwayland-satellite.path = lib.getExe pkgs.xwayland-satellite;

          input = {
            keyboard.xkb.layout = "us";

            touchpad = {
              tap = _: { };
              natural-scroll = _: { };
            };
          };

          layout = {
            gaps = 8;

            center-focused-column = "always";

            default-column-width = {
              proportion = 0.85;
            };

            focus-ring = {
              width = 3;
              active-color = "#e6b450";
              inactive-color = "#0b0e14";
              urgent-color = "#d95757";
            };

            shadow = {
              color = "#00000070";
            };

            tab-indicator = {
              active-color = "#e6b450";
              inactive-color = "#7d5507";
              urgent-color = "#d95757";
            };

            insert-hint = {
              color = "#e6b45080";
            };

            background-color = "transparent";
          };

          overview = {
            workspace-shadow = {
              off = _: { };
            };
          };

          blur = {
            passes = 1; # more passes = stronger blur (default: 3)
            offset = 2.5; # sample distance per pass (default: 3.0)
            noise = 0.02; # grain overlay (default: 0.02)
            saturation = 1.0; # color saturation boost (default: 1.5)
          };

          window-rules = [
            {
              geometry-corner-radius = 10;
              clip-to-geometry = true;
            }
            {
              matches = [
                {
                  app-id = "org.keepassxc.KeePassXC";
                }
                {
                  app-id = "org.gnome.World.Secrets";
                }
              ];
              block-out-from = "screen-capture";
            }
            {
              # Blur
              background-effect = {
                blur = true;
                xray = false;
              };
            }
          ];

          layer-rules = [
            {
              matches = [
                {
                  # namespace = "^noctalia-overview*";
                  namespace = "^noctalia-wallpaper*";
                }
              ];
              place-within-backdrop = true;
            }
            {
              # Blur
              matches = [
                {
                  namespace = "^noctalia-(background|launcher-overlay|dock)-.*$";
                }
              ];
              background-effect = {
                xray = false;
              };
            }
          ];

          binds =
            let
              noctalia = "noctalia-shell ipc call";
            in
            {
              "Mod+Shift+Slash".show-hotkey-overlay = _: { };
              "Mod+Shift+E".quit = _: { };
              "Mod+Q" = _: {
                props.repeat = false;
                content.close-window = _: { };
              };

              # Screenshots
              "Print".screenshot = _: { };
              "Ctrl+Print".screenshot-screen = _: { };
              "Alt+Print".screenshot-window = _: { };

              # Launch wl mirror
              # "Mod+Shift+P".spawn-sh = "wl-mirror eDP-1";

              # Launch apps
              "Mod+Return".spawn-sh = "kitty";
              "Mod+E".spawn-sh = "thunar";
              "Mod+W".spawn-sh = "firefox";
              "Mod+Escape".spawn-sh = "kitty -e ${lib.getExe pkgs.btop}";

              # Noctalia-shell core bindings
              "Mod+Space" = _: {
                props.repeat = false;
                content.spawn-sh = "${noctalia} launcher toggle";
              };
              "Mod+semicolon".spawn-sh = "${noctalia} launcher emoji";
              "Mod+V".spawn-sh = "${noctalia} launcher clipboard";
              "Mod+I".spawn-sh = "${noctalia} settings toggle";
              "Mod+T".spawn-sh = "${noctalia} wallpaper toggle";
              "Mod+L".spawn-sh = "${noctalia} lockScreen lock";
              "Mod+P".spawn-sh = "${noctalia} powerProfile cycle";

              # Audio controls
              "XF86AudioRaiseVolume".spawn-sh = "${noctalia} volume increase";
              "XF86AudioLowerVolume".spawn-sh = "${noctalia} volume decrease";
              "XF86AudioMute".spawn-sh = "${noctalia} volume muteOutput";

              # Media controls
              "XF86AudioPlay".spawn-sh = "${noctalia} media playPause";
              "XF86AudioStop".spawn-sh = "${noctalia} media pause";
              "XF86AudioNext".spawn-sh = "${noctalia} media next";
              "XF86AudioPrev".spawn-sh = "${noctalia} media previous";

              # Brightness controls
              "XF86MonBrightnessUp".spawn-sh = "${noctalia} brightness increase";
              "XF86MonBrightnessDown".spawn-sh = "${noctalia} brightness decrease";

              # Overview
              "Mod+O" = _: {
                props.repeat = false;
                content.toggle-overview = _: { };
              };

              # Togle maximize and fullscreen window
              "Mod+F".maximize-column = _: { };
              "Mod+Shift+F".fullscreen-window = _: { };

              # Adjust width window column
              "Mod+Minus".set-column-width = "-5%";
              "Mod+Equal".set-column-width = "+5%";

              # Adjust height windown column
              "Mod+Shift+Minus".set-window-height = "-5%";
              "Mod+Shift+Equal".set-window-height = "+5%";

              # Toggle floating and tiling layout.
              "Mod+Alt+Space".toggle-window-floating = _: { };
              "Mod+Ctrl+Alt+Space".switch-focus-between-floating-and-tiling = _: { };

              # Window keybind management.
              "Mod+Left".focus-column-left = _: { };
              "Mod+Down".focus-window-down = _: { };
              "Mod+Up".focus-window-up = _: { };
              "Mod+Right".focus-column-right = _: { };

              "Mod+Ctrl+Up".move-window-up = _: { };
              "Mod+Ctrl+Down".move-window-down = _: { };
              "Mod+Ctrl+Left".move-column-left = _: { };
              "Mod+Ctrl+Right".move-column-right = _: { };

              "Mod+Shift+Up".focus-workspace-up = _: { };
              "Mod+Shift+Down".focus-workspace-down = _: { };
              "Mod+Ctrl+Shift+Up".move-window-to-workspace-up = _: { };
              "Mod+Ctrl+Shift+Down".move-window-to-workspace-down = _: { };
              "Mod+Ctrl+Page_Up".move-column-to-workspace-up = _: { };
              "Mod+Ctrl+Page_Down".move-column-to-workspace-down = _: { };
              "Mod+Shift+Page_Up".move-workspace-up = _: { };
              "Mod+Shift+Page_Down".move-workspace-down = _: { };

              "Mod+WheelScrollDown" = _: {
                props.cooldown-ms = 150;
                content.focus-column-right = _: { };
              };
              "Mod+WheelScrollUp" = _: {
                props.cooldown-ms = 150;
                content.focus-column-left = _: { };
              };
              "Mod+Ctrl+WheelScrollDown" = _: {
                props.cooldown-ms = 150;
                content.move-column-right = _: { };
              };
              "Mod+Ctrl+WheelScrollUp" = _: {
                props.cooldown-ms = 150;
                content.move-column-left = _: { };
              };

              "Mod+Shift+WheelScrollDown" = _: {
                props.cooldown-ms = 150;
                content.focus-workspace-down = _: { };
              };
              "Mod+Shift+WheelScrollUp" = _: {
                props.cooldown-ms = 150;
                content.focus-workspace-up = _: { };
              };
              "Mod+Ctrl+Shift+WheelScrollDown" = _: {
                props.cooldown-ms = 150;
                content.move-column-to-workspace-down = _: { };
              };
              "Mod+Ctrl+Shift+WheelScrollUp" = _: {
                props.cooldown-ms = 150;
                content.move-column-to-workspace-up = _: { };
              };
            };

          # Source animations: https://github.com/Xansidev/nirimation
          extraConfig = /* kdl */ ''
            animations {
              workspace-switch {
                spring damping-ratio=0.8 stiffness=600 epsilon=0.0001
              }

              horizontal-view-movement {
                spring damping-ratio=0.8 stiffness=600 epsilon=0.0001
              }

              window-open {
                duration-ms 400
                curve "ease-out-quad"
                custom-shader r"
                  vec4 fall_from_top(vec3 coords_geo, vec3 size_geo) {
                    float progress = niri_clamped_progress * niri_clamped_progress;
                    vec2 coords = (coords_geo.xy - vec2(0.5, 0.0)) * size_geo.xy;
                    coords.y += (1.0 - progress) * 1440.0;
                    float max_angle = mix(-0.5, 0.5, floor(niri_random_seed * 4.0) / 3.0);
                    float angle = (1.0 - progress) * max_angle;
                    mat2 rotate = mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
                    coords = rotate * coords;
                    coords_geo = vec3(coords / size_geo.xy + vec2(0.5, 0.0), 1.0);
                    vec3 coords_tex = niri_geo_to_tex * coords_geo;
                    return texture2D(niri_tex, coords_tex.st);
                  }

                  vec4 open_color(vec3 coords_geo, vec3 size_geo) {
                    return fall_from_top(coords_geo, size_geo);
                  }
                "
              }

              window-close {
                duration-ms 700
                curve "ease-out-quad"
                custom-shader r"
                  vec4 fall_and_rotate(vec3 coords_geo, vec3 size_geo) {
                    float progress = niri_clamped_progress * niri_clamped_progress;
                    vec2 coords = (coords_geo.xy - vec2(0.5, 1.0)) * size_geo.xy;
                    coords.y -= progress * 1440.0;
                    float random = (niri_random_seed - 0.5) / 2.0;
                    random = sign(random) - random;
                    float max_angle = 0.5 * random;
                    float angle = progress * max_angle;
                    mat2 rotate = mat2(cos(angle), -sin(angle), sin(angle), cos(angle));
                    coords = rotate * coords;
                    coords_geo = vec3(coords / size_geo.xy + vec2(0.5, 1.0), 1.0);
                    vec3 coords_tex = niri_geo_to_tex * coords_geo;
                    vec4 color = texture2D(niri_tex, coords_tex.st);
                    color.a *= (1.0 - progress);
                    return color;
                  }

                  vec4 close_color(vec3 coords_geo, vec3 size_geo) {
                    return fall_and_rotate(coords_geo, size_geo);
                  }
                "
              }
            }
          '';
        };
      };
    };
}
