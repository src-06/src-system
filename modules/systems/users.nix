{
  unstable,
  username,
  homeDirectory,
  ...
}:

{
  users.users.${username} = {
    isNormalUser = true;
    home = homeDirectory;
    description = "Violet Evergarden";
    extraGroups = [
      "networkmanager"
      "wheel"
      "libvirt"
    ];
    shell = unstable.fish;
  };

  users.users.root = {
    shell = unstable.fish;
  };
}
