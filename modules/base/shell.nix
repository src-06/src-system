{
  flake.nixosModules.base =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        bat
        eza
        rip2
        rsync
        yt-dlp
      ];

      programs.fish = {
        enable = true;

        interactiveShellInit = ''
          set fish_greeting

          # fish_add_path ~/.cargo/bin
          # fish_add_path ~/.config/composer/vendor/bin
          # fish_add_path ~/.local/bin
        '';
        shellAliases = {
          clear = "printf '\\033[2J\\033[3J\\033[1;1H'";
          claer = "printf '\\033[2J\\033[3J\\033[1;1H'";

          cat = "bat";
          diff = "diff --color=auto";
          grep = "grep --color=auto";

          ls = "eza -lah --icons --group-directories-first";
          tree = "eza --icons --group-directories-first --tree";

          rs = "rsync -av --human-readable";
          rsd = "rsync -av --delete --human-readable";
          rst = "rsync -av --delete --dry-run --human-readable";

          yt-dlm = "yt-dlp -x --audio-format opus --audio-quality 0 --embed-metadata --embed-thumbnail --download-archive .ytm_list --no-overwrites -o '%(uploader)s - %(title)s.%(ext)s'";
          yt-dlv = "yt-dlp -f 'bv*[height<=720][ext=mp4]+ba*' --embed-metadata -o '%(uploader)s - %(title)s.%(ext)s'";
        };
      };

      programs.starship = {
        enable = true;

        settings = {
          add_newline = false;

          format = ''
            [ ╭─────────▶](bg:src_bg3 fg:src_fg0)$os$hostname$username[](bg:src_bg1 fg:src_bg3)$nix_shell$conda[](bg:src_bg0 fg:src_bg1)$time$shell[](fg:src_bg0)
            [ │](bg:src_bg3 fg:src_fg0)$directory[](bg:src_bg2 fg:src_bg3)$git_branch$git_status[](bg:src_bg1 fg:src_bg2)$nodejs$php$python[](fg:src_bg1)
            [ ╰](bg:src_bg3 fg:src_fg0)$character[ ](fg:src_bg3)'';

          palette = "src_06";

          palettes.src_06 = {
            src_fg0 = "#EFF5F6";
            src_bg0 = "#0B1019";
            src_bg1 = "#1a273e";
            src_bg2 = "#2F456A";
            src_bg3 = "#3F5C8D";
            src_green = "#3BC45F";
            src_red = "#DF2020";
          };

          ################################################################################

          os = {
            disabled = false;
            style = "bg:src_bg3 fg:src_fg0";

            symbols = {
              Arch = " ";
              Debian = " ";
              Fedora = " ";
              NixOS = " ";
              openSUSE = " ";
              Linux = " ";
              Windows = " ";
            };
          };

          hostname = {
            style = "bg:src_bg3 fg:src_fg0";
            format = "[ $ssh_symbol$hostname]($style)";
            ssh_only = false;
          };

          username = {
            show_always = true;
            style_user = "bg:src_bg3 fg:src_fg0";
            style_root = "bg:src_bg3 fg:src_fg0";
            format = "[ 󰀄 $user ]($style)";
          };

          ################################################################################

          nix_shell = {
            symbol = "";
            style = "bg:src_bg1";
            format = "[[ $symbol$state( \($name\)) ](bg:src_bg1 fg:src_fg0)]($style)";
          };

          conda = {
            style = "bg:src_bg1";
            format = "[[ $symbol( $environment) ](bg:src_bg1 fg:src_fg0)]($style)";
          };

          ################################################################################

          time = {
            disabled = false;
            time_format = "%R";
            style = "bg:src_bg0";
            format = "[[  $time](bg:src_bg0 fg:src_fg0)]($style)";
          };

          shell = {
            disabled = false;
            style = "bg:src_bg0";
            format = "[[  $indicator ](bg:src_bg0 fg:src_fg0)]($style)";
            bash_indicator = "bash";
            fish_indicator = "fish";
            powershell_indicator = "PowerShell";
          };

          ################################################################################
          ################################################################################

          directory = {
            style = "bg:src_bg3 fg:src_fg0";
            format = "[  $path ]($style)";
            truncation_length = 2;
            truncation_symbol = "…/";

            substitutions = {
              "Documents" = "󰈙";
              "Downloads" = "";
              "Music" = "󰝚";
              "Pictures" = "";
              "Projects" = "󰲋";
              "Videos" = "";
            };
          };

          ################################################################################

          git_branch = {
            symbol = "";
            style = "bg:src_bg2";
            format = "[[ $symbol $branch ](fg:src_fg0 bg:src_bg2)]($style)";
          };

          git_status = {
            style = "bg:src_bg2";
            format = "[[($all_status$ahead_behind )](fg:src_fg0 bg:src_bg2)]($style)";
          };

          ################################################################################

          nodejs = {
            symbol = "";
            style = "bg:src_bg1";
            format = "[[ $symbol( $version) ](bg:src_bg1 fg:src_fg0)]($style)";
          };

          php = {
            symbol = "";
            style = "bg:src_bg1";
            format = "[[ $symbol( $version) ](bg:src_bg1 fg:src_fg0)]($style)";
          };

          python = {
            symbol = "";
            style = "bg:src_bg1";
            format = "[[ $symbol( $version) ](bg:src_bg1 fg:src_fg0)]($style)";
          };

          ################################################################################
          ################################################################################

          character = {
            success_symbol = "[❱](bold bg:src_bg3 fg:src_green)";
            error_symbol = "[❱](bold bg:src_bg3 fg:src_red)";
            format = "$symbol";
          };
        };

        presets = [
          "nerd-font-symbols"
        ];
      };
    };
}
