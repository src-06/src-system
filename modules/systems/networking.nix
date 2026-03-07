{ hostName, ... }:

{
  networking = {
    inherit hostName;

    enableIPv6 = true;
    # wireless.enable = true;
    networkmanager.enable = true;

    firewall = {
      enable = true;
      # allowPing = true;
      allowedTCPPorts = [ 80 ];
      trustedInterfaces = [ "virbr0" ];
    };
  };
}
