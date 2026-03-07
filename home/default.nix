{
  username,
  homeDirectory,
  stateVersion,
  ...
}:

{
  imports = [
    ./browsers
    ./development
    ./editing
    ./editors
    ./games
    ./media
    ./office
    ./tools
    ./ui
  ];

  home = {
    inherit username homeDirectory stateVersion;
  };
}
