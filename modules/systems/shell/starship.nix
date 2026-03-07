{ ... }:

{
  programs.starship = {
    enable = true;

    settings = {
      format = ''
        [╭──────────────▶](blue bold) $os$username ~ $shell
        [│](blue bold) $directory$nix_shell$git_branch$git_commit$git_state$git_metrics$git_status$c$cpp$php$nodejs$bun$package
        [╰╴$character](blue bold)'';

      right_format = "$cmd_duration";

      add_newline = false;

      username = {
        show_always = true;
        format = "[$user]($style)";
      };

      character = {
        success_symbol = "[❯](bold green)";
        error_symbol = "[✘](bold red)";
      };

      os = {
        disabled = false;
        style = "bold bright-blue";

        symbols = {
          Arch = " ";
          NixOS = " ";
        };
      };

      cmd_duration = {
        min_time = 0;
        format = "[ $duration](bold) ";
      };

      shell = {
        disabled = false;
        fish_indicator = "fish";
      };

      cpp.disabled = false;
    };
  };
}
