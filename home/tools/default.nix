{ pkgs, unstable, ... }:

{
  imports = [
    ./thunderbird.nix
  ];

  home.packages =
    (with pkgs; [
      fastfetch
      gucharmap
      nwg-look
      kdePackages.qt6ct
      kitty
    ])
    ++ (with unstable; [
      yt-dlp
    ]);
}
