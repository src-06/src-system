{
  flake.nixosModules.extra-virtualbox = {
    virtualisation.virtualbox.host = {
      enable = true;
      # enableExtensionPack = true;
    };

    users.extraGroups.vboxusers.members = [ "src-06" ];
  };
}
