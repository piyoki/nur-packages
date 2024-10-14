{ pkgs, lib, ... }:

with pkgs;
let
  pname = "gitmux";
  version = "v0.11.2";
  meta = with lib; {
    homepage = "https://github.com/arl/gitmux";
    description = "Git in your tmux status bar ";
    license = licenses.gpl3Only;
    mainProgram = "gitmux";
    maintainers = with maintainers; [ kev ];
  };
in
buildGoModule {
  inherit pname version meta;

  nativeBuildInputs = with pkgs; [ git ];

  src = fetchFromGitHub {
    owner = "gitmux";
    repo = "arl";
    rev = "88a3d6df03f4e077301c0e0aa462b2c4d726f30e";
    hash = "sha256-0Cw98hTg8qPu7BUTBDEgFBOpoCxstPW9HeNXQUUjgGA=";
  };

  vendorHash = "sha256-PHY020MIuLlC1LqNGyBJRNd7J+SzoHbNMPAil7CKP/M=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];
}
