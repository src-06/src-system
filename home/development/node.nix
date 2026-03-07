{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodePackages.nodejs
    nodePackages.pnpm
    nodePackages.yarn
  ];
}
