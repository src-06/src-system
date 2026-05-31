{
  flake.nixosModules.extra-appimage = {
    programs.appimage = {
      enable = true;
      binfmt = true;
    };
  };
}
