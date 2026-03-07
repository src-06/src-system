{ pkgs, ... }:

{
  imports = [
    ./vscode.nix
  ];

  home.packages = with pkgs; [
    zed-editor
  ];
}
