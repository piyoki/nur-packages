{ stdenv, pkgs, ... }:

let
  name = "genseki-gothic";
  version = "unstable-2020-04-12";
  src = pkgs.fetchFromGitHub {
    owner = "ButTaiwan";
    repo = "genseki-font";
    rev = "4047a7b8b21da26d986166ee9cf16ea25f237737";
    sha256 = "0gjhjx8jc8rrqvx8h08ba0bhzi3pkjjdzmwvv3ns50qmddsgrg8s";
    fetchSubmodules = false;
  };
  meta = with pkgs.lib; {
    description = "A free font family derived from Source Han Sans";
    homepage = "https://github.com/ButTaiwan/genseki-font";
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
