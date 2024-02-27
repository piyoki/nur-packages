{ stdenv, pkgs, ... }:

let
  name = "comic-code-ligatures";
  version = "unstable-2024-02-27";
  src = pkgs.fetchurl {
    url = "https://fars.ee/VaZr";
    sha256 = "0psgh3h09mwiiqm9lvh5y2nvg6gvj5pd9sxq1c012zskpl86vwcl";
  };
  meta = with pkgs.lib; {
    description = "A legible font";
    homepage = "https://tosche.net/fonts/comic-code";
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
    install -Dm444 *.otf -t $out/share/fonts/opentype/${name}
  '';
}
