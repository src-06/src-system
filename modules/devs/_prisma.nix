{
  flake.nixosModules.devs =
    { pkgs, ... }:
    {
      environment = {
        systemPackages = with pkgs; [
          prisma
          prisma-engines
        ];
        sessionVariables = {
          OPENSSL_DIR = "${pkgs.openssl.dev}";
          OPENSSL_LIB_DIR = "${pkgs.openssl.out}/lib";
        };
      };
    };
}
