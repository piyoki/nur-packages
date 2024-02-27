{ stdenv, pkgs, ... }:

let
  name = "helloworld";
  version = "unstable-2024-02-27";
  src = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "helloworld.nix";
    rev = "4c5c325ec850213287120eae8fd31a601c155cf0";
    sha256 = "1zx7s4l5rzyq0lsi6yvknqjxaf1m82iwv4ymgb633h1zxq0vqmr0";
    fetchSubmodules = false;
  };
in
stdenv.mkDerivation rec {
  inherit src name version;
  buildPhase = "gcc -o ${name} ./hello.c";
  installPhase = "mkdir -p $out/bin; install -Dm755 ${name} $out/bin";
}
