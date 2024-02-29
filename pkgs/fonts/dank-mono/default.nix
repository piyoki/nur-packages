{ stdenv, pkgs, ... }:

let
  name = "dank-mono";
  version = "unstable-2021-09-11";
  src = pkgs.fetchFromGitHub {
    owner = "notshekhar";
    repo = "Dank-Mono-Font";
    rev = "3c6a54ffb6c892aec158a92a769d480f30628b19";
    sha256 = "0abwjpipgn86ka74145dm60pyjihgrj2qly4c7jrbwnm21qkfnw1";
    fetchSubmodules = false;
  };
  meta = with pkgs.lib; {
    description = "The coding typeface for aesthetes";
    homepage = "https://philpl.gumroad.com/l/dank-mono";
    license = licenses.ofl;
    platforms = platforms.linux;
    mainProgram = pname;
    maintainers = with maintainers; [ kev ];
  };
in
stdenv.mkDerivation rec {
  inherit src name version meta;
  installPhase = ''
    install -Dm444 *.ttf -t $out/share/fonts/opentype/${name}
  '';
}
