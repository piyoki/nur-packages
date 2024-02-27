{ stdenv, pkgs, ... }:

let
  name = "comic-code";
  version = "unstable-2024-02-27";
  regularSrc = pkgs.fetchurl {
    url = "https://dtinth.github.io/comic-mono-font/ComicMono.ttf";
    sha256 = "15kispdga5bxw0r89sfwq2s3k116s3jgyzknxkqan5iaj9g45h9v";
  };
  boldSrc = pkgs.fetchurl {
    url = "https://dtinth.github.io/comic-mono-font/ComicMono-Bold.ttf";
    sha256 = "0zhfwvbiz7hhkqj7fs6c2nd33cpvn9zn5phfm8n23xf7vmlxm5i3";
  };
  meta = with pkgs.lib; {
    description = "A legible monospace font";
    homepage = "https://dtinth.github.io/comic-mono-font/";
    license = licenses.ofl;
    platforms = platforms.linux;
    mainProgram = pname;
    maintainers = with maintainers; [ kev ];
  };
in
stdenv.mkDerivation rec {
  inherit name version meta;
  src = [ regularSrc boldSrc ];
  unpackPhase = ''
    for srcFile in $src; do
      cp $srcFile $(stripHash $srcFile)
    done
  '';
  installPhase = ''
    install -Dm444 *.ttf -t $out/share/fonts/opentype/${name}
  '';
}
