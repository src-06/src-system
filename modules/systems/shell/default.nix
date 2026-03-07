{ pkgs, ... }:

let
  shellAliases = {
    cat = "bat";
    diff = "diff --color=auto";
    grep = "grep --color=auto";
    ls = "eza --icons --group-directories-first";
  };
in
{
  imports = [
    ./fish.nix
    ./starship.nix
    ./zsh.nix
  ];

  environment.systemPackages = with pkgs; [
    (writeShellApplication {
      name = "pkgs-lock";
      runtimeInputs = [ jq ];
      text = builtins.readFile ./scripts/pkgs-lock.sh;
    })

    bat
    eza
    jq
  ];

  programs = {
    fish = { inherit shellAliases; };
    zsh = { inherit shellAliases; };
  };
}
