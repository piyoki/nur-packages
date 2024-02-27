{
  description = "My personal NUR repository";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    let
      # lib = nixpkgs.lib;
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
    in
    (flake-utils.lib.eachSystem supportedSystems (system:
      let
        pkgs = (import nixpkgs) { inherit system; config.allowUnfree = true; };
      in
      {
        packages = {
          default = pkgs.callPackage ./pkgs/helloworld { };
          helloworld = pkgs.callPackage ./pkgs/helloworld { };
          genseki-gothic = pkgs.callPackage ./pkgs/fonts/genseki-gothic { };
          comic-code = pkgs.callPackage ./pkgs/fonts/comic-code { };
        };
      }));
}
