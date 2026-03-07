{ unstable, ... }:

{
  programs.fish = {
    enable = true;
    package = unstable.fish;
    interactiveShellInit = ''
      set fish_greeting
    '';
  };
}
