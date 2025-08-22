{ stdenv, pkgs, ... }:

let
  name = "vt323";
  version = "unstable-2024-02-27";
  src = pkgs.fetchurl {
    url = "https://fars.ee/EERJ";
    sha256 = "sha256-SpK1+z6IR/Fd3D76NoGbyg6VVmjonvKwv3bjYrsRgW0=";
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
    install -Dm444 VT323-Regular.ttf -t $out/share/fonts/opentype/${name}
  '';
}
