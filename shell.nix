{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
  packages = [
    pkgs.terraform
    pkgs.nghttp2
    pkgs.curl
  ];
}
