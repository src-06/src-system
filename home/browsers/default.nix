{ unstable, ... }:

{
  home.packages = with unstable; [
    brave
    firefox
    google-chrome
  ];
}
