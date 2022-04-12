let
  # Pinned nixpkgs, deterministic
  nixpkgs = import (fetchTarball ("https://github.com/NixOS/nixpkgs/archive/9fa1ca6fe69543143ed34cc0dc9f44de6ba5c2f1.tar.gz")) { };
in
nixpkgs.mkShell {
  buildInputs = [
    nixpkgs.nghttp2
  ];
}
