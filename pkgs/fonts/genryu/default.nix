{ stdenv, pkgs, ... }:

let
  name = "genryu";
  version = "v2.100";
  src = pkgs.fetchFromGitHub {
    owner = "ButTaiwan";
    repo = "genryu-font";
    rev = "v2.100";
    sha256 = "1j9qax74fpdxkr62vjaad66hrnvh3v4j359738w0xpq1c8dh2r52";
    fetchSubmodules = false;
  };
  meta = with pkgs.lib; {
    description = "A free font family derived from Source Han Sans";
    homepage = "https://github.com/ButTaiwan/genryu-font";
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
