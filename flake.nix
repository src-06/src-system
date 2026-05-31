{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    wrapper-modules = {
      url = "github:BirdeeHub/nix-wrapper-modules";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-shell = {
      url = "github:noctalia-dev/noctalia-shell/v4.7.7";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs:
    let
      inherit (inputs.nixpkgs) lib;

      import-tree =
        path:
        builtins.filter (
          file:
          let
            str = toString file;
            base = baseNameOf str;
          in
          lib.hasSuffix ".nix" str
          && base != "flake.nix"
          && !lib.hasInfix "/result/" str
          && !lib.hasInfix "/_" str
          && !lib.hasPrefix "_" base
        ) (lib.filesystem.listFilesRecursive path);
    in
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = import-tree ./.;
    };
}
