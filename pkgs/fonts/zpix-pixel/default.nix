{ stdenv, pkgs, ... }:

let
  name = "zpix-pixel";
  version = "unstable-2023-05-18";
  src = pkgs.fetchFromGitHub {
    owner = "SolidZORO";
    repo = "zpix-pixel-font";
    rev = "e11924b6e8517c9f34a259fdfc6f18d3352d02c2";
    sha256 = "1cggpfl6fck4k3v92681f2838dj5kl5z8izr5kx4fpi0yz3nrm05";
    fetchSubmodules = false;
  };
  meta = with pkgs.lib; {
    description = "Zpix (最像素) is a pixel font (像素字体), supporting English, Traditional Chinese, Simplified Chinese and Japanese.";
    homepage = "https://github.com/SolidZORO/zpix-pixel-font";
    license = licenses.ofl;
    platforms = platforms.linux;
    mainProgram = pname;
    maintainers = with maintainers; [ kev ];
  };
in
stdenv.mkDerivation rec {
  inherit src name version meta;
  installPhase = ''
    install -Dm444 dist/*.ttf -t $out/share/fonts/opentype/${name}
  '';
}
