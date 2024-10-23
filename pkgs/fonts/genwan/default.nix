{ stdenv, pkgs, ... }:

let
  name = "genwan";
  version = "v2.100";
  src = pkgs.fetchFromGitHub {
    owner = "ButTaiwan";
    repo = "genwan-font";
    rev = "v2.100";
    sha256 = "0p2wkw3s1riljlvbcw7sp4xlw6sbrxfgwisxngm1h68hh9vz7d0r";
    fetchSubmodules = false;
  };
  meta = with pkgs.lib; {
    description = "A free font family derived from Source Han Sans";
    homepage = "https://github.com/ButTaiwan/genwan-font";
    license = licenses.ofl;
    platforms = platforms.linux;
    mainProgram = pname;
    maintainers = with maintainers; [ kev ];
  };
in
stdenv.mkDerivation rec {
  inherit src name version meta;
  installPhase = ''
    install -Dm444 ttc/*.ttc -t $out/share/fonts/opentype/${name}
  '';
}
