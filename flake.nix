{
  description = "My personal NUR repository";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable-small";
    flake-utils.url = "github:numtide/flake-utils";
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    nix-fast-build.url = "github:Mic92/nix-fast-build";
  };

  outputs = { nixpkgs, flake-utils, ... }@inputs: with inputs;
    let
      # lib = nixpkgs.lib;
      supportedSystems = [ "x86_64-linux" "aarch64-linux" ];
    in
    flake-utils.lib.eachSystem supportedSystems (system:
      let
        pkgs = (import nixpkgs) { inherit system; config.allowUnfree = true; };
        genChecks = system: (pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            nixpkgs-fmt.enable = true; # formatter
            statix.enable = true; # linter
            deadnix.enable = true; # linter
          };
        });
      in
      {
        # checks
        checks.pre-commit-check = genChecks system;
        packages = {
          # eval
          nix-fast-build = inputs.nix-fast-build.packages.${system}.default;

          # pkgs
          helloworld = pkgs.callPackage ./pkgs/helloworld { };
          glider = pkgs.callPackage ./pkgs/glider { };
          mosdns = pkgs.callPackage ./pkgs/mosdns { };
          gitmux = pkgs.callPackage ./pkgs/gitmux { };

          # fonts
          genryu = pkgs.callPackage ./pkgs/fonts/genryu { };
          genwan = pkgs.callPackage ./pkgs/fonts/genwan { };
          genseki-gothic = pkgs.callPackage ./pkgs/fonts/genseki-gothic { };
          comic-code = pkgs.callPackage ./pkgs/fonts/comic-code { };
          comic-code-ligatures = pkgs.callPackage ./pkgs/fonts/comic-code-ligatures { };
          vt323 = pkgs.callPackage ./pkgs/fonts/vt323 { };
          dank-mono = pkgs.callPackage ./pkgs/fonts/dank-mono { };
          zpix-pixel = pkgs.callPackage ./pkgs/fonts/zpix-pixel { };
        };
      });
}
