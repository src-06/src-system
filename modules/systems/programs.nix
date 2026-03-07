{
  # unstable,
  ...
}:

{
  programs = {
    direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };
    nix-ld.enable = true;
    gamemode.enable = true;
    vim.enable = true;
    virt-manager.enable = true;
    localsend = {
      enable = true;
      openFirewall = true;
    };
    # steam = {
    #   enable = true;
    #   package = unstable.steam;
    #   localNetworkGameTransfers.openFirewall = true;
    # };
  };
}
