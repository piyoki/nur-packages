{ stdenv, pkgs, ... }:

let
  name = "dogica";
  version = "unstable-2024-03-01";
  src = pkgs.fetchurl {
    url = "https://www.ffonts.net/Dogica.font.zip";
    sha256 = "1ahgfvl3p1ax20prqgi5j2f3qzqdqs1s47lafbzr3w7p2i5h5h09";
  };
  meta = with pkgs.lib; {
    description = "A pixel font";
    homepage = "https://www.dafont.com/dogica.font";
    license = licenses.ofl;
    platforms = platforms.linux;
    mainProgram = pname;
    maintainers = with maintainers; [ kev ];
  };
in
stdenv.mkDerivation rec {
  inherit name version src meta;
  nativeBuildInputs = with pkgs; [ unzip ];
  unpackPhase = ''
    unzip $src
  '';
  installPhase = ''
    install -Dm444 TTF/*.ttf -t $out/share/fonts/opentype/${name}
  '';
}
