{ stdenv, pkgs, ... }:

let
  name = "iansui";
  version = "v1.000";
  src = pkgs.fetchFromGitHub {
    owner = "ButTaiwan";
    repo = "iansui";
    rev = "v1.000";
    sha256 = "1jwn8y9qk75j91incg66icc76fx7h82nqnh7hw5lr7jz8fdrrs4f";
    fetchSubmodules = false;
  };
  meta = with pkgs.lib; {
    description = "芫荽，基於 Klee One 改造的學習用台灣繁體字型 ";
    homepage = "https://github.com/ButTaiwan/iansui";
    license = licenses.ofl;
    platforms = platforms.linux;
    mainProgram = pname;
    maintainers = with maintainers; [ kev ];
  };
in
stdenv.mkDerivation rec {
  inherit src name version meta;
  installPhase = ''
    install -Dm444 Iansui-Regular.ttf -t $out/share/fonts/opentype/${name}
  '';
}
