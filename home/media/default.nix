{ pkgs, ... }:

{
  home.packages = with pkgs; [
    obs-studio
    youtube-music
  ];
}
