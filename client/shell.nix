{ pkgs ? import <nixpkgs> {} }:
let
  my-python = pkgs.python3;
  python-with-my-packages = my-python.withPackages (p: with p; [
    jupyterlab
    pandas
    matplotlib
    seaborn
  ]);

  pkgs = import (fetchTarball ("https://github.com/NixOS/nixpkgs/archive/9fa1ca6fe69543143ed34cc0dc9f44de6ba5c2f1.tar.gz")) { };
in
pkgs.mkShell {
    packages = [
        pkgs.iperf3
        pkgs.collectd
        python-with-my-packages
    ];
}
