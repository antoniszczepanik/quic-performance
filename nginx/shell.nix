{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "nginx";
  packages = [
    pkgs.collectd
    pkgs.mercurial
    pkgs.git
    pkgs.cmake
    pkgs.gnumake
    pkgs.go
    pkgs.pcre
    pkgs.boringssl
    pkgs.wget
    pkgs.gnutar
    pkgs.zlib
    pkgs.mkcert
    pkgs.iperf3
  ];
  shellHook = ''
    echo "Hello from Nginx shell!"
  '';
}
