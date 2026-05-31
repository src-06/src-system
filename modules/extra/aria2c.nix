{
  flake.nixosModules.extra-aria2c =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.aria2
      ];

      systemd.services.aria2c = {
        description = "Aria2 RPC Daemon";
        after = [ "network.target" ];
        wantedBy = [ "multi-user.target" ];
        serviceConfig = {
          ExecStart = "${pkgs.aria2}/bin/aria2c --enable-rpc=true --rpc-secret='Us9zFOM1Unk75f5L' --rpc-listen-all=true --rpc-allow-origin-all=true";
          Restart = "on-failure";
        };
      };
    };
}
