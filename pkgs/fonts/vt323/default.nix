{ stdenv, pkgs, ... }:

let
  name = "vt323";
  version = "unstable-2024-02-27";
  src = pkgs.fetchurl {
    url = "https://allbestfonts.com/wp-content/uploads/2017/08/VT323.zip";
    sha256 = "0zm3847fsqr9mb1v3g4h3bdg4mnpfps24x79fjs66r9mwmz72gwh";
  };
  meta = with pkgs.lib; {
    description = "An ancient font";
    homepage = "https://fonts.google.com/specimen/VT323";
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
    install -Dm444 VT323/*.ttf -t $out/share/fonts/opentype/${name}
  '';
}
