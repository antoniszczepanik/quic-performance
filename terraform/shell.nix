{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  name = "nginx";
  packages = [
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
  ];
  shellHook = ''
    echo "Hello from Nginx shell!"
  '';
}