{ pkgs, lib, ... }:

with pkgs;
let
  pname = "mosdns";
  version = "unstable-2024-08-14-025823c";
  meta = with lib; {
    homepage = "https://github.com/IrineSistiana/mosdns";
    description = "Modular, pluggable DNS forwarder";
    license = licenses.gpl3Only;
    mainProgram = "mosdns";
    maintainers = with maintainers; [ kev ];
  };
  systemdFile = ./systemd/mosdns.service;
in
buildGoModule {
  inherit pname version meta;

  src = fetchFromGitHub {
    owner = "IrineSistiana";
    repo = "mosdns";
    rev = "025823c1a5c9753c0e35f8b444b9e3c4472d37d1";
    hash = "sha256-nSqSfbpi91W28DaLjCsWlPiLe1gLVHeZnstktc/CLag=";
  };

  vendorHash = "sha256-RpvWkIDhHSNbdkpBCcXYbbvbmGiG15qyB5aEJRmg9s4=";

  ldflags = [
    "-s"
    "-w"
    "-X main.version=${version}"
  ];

  postInstall = ''
    cp ${systemdFile} $out/mosdns@.service
    substituteInPlace $out/mosdns@.service \
      --replace "/usr/bin/mosdns" "$out/bin/mosdns"
    install -Dm444 -t "$out/lib/systemd/system/" $out/mosdns@.service
    rm $out/mosdns@.service
  '';
}
