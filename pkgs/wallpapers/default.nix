{ stdenv, pkgs, ... }:

let
  name = "wallpapers";
  version = "unstable-2024-03-07";
  src = pkgs.fetchFromGitHub {
    owner = "yqlbu";
    repo = "nur-assets";
    rev = "95060b4bc9f7123d840b48a526c23280feb4c7d6";
    sha256 = "09dz2c263k3yy4m60zbbahlgz3qjkk8aghjk9apmqzl97ranz4pm";
    fetchSubmodules = false;
  };
  meta = with pkgs.lib; {
    description = "NUR assets for personal usage";
    homepage = "https://github.com/yqlbu/nur-assets";
    license = licenses.ofl;
    platforms = platforms.linux;
    mainProgram = pname;
    maintainers = with maintainers; [ kev ];
  };
in
stdenv.mkDerivation rec {
  inherit src name version meta;
  installPhase = ''
    install -Dm444 wallpapers/* -t $out/share/${name}
  '';
}
