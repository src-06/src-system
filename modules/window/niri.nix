{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    xwayland-satellite
    btop
  ];

  programs = {
    niri = {
      enable = true;
      useNautilus = false;
    };

    xwayland.enable = true;
  };
}
