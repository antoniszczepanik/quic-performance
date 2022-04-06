#!/usr/bin/env nix-shell
#!nix-shell shell.nix
#!nix-shell -i bash

set -exou pipefail

# Download nginx
wget https://hg.nginx.org/nginx-quic/archive/55b38514729b.tar.gz --no-check-certificate
tar xf 55b38514729b.tar.gz

# Configure & build
cd nginx-quic-55b38514729b
./auto/configure --prefix="/home/ubuntu/.local/opt/nginx" \
                 --with-http_v3_module       \
                 --with-stream_quic_module   \
                --with-cc-opt="-I../boringssl/include"     \
                --with-ld-opt="-L../boringssl/build/ssl    \
                                 -L../boringssl/build/crypto"

make
make install

mkcert \
  -key-file /home/ubuntu/.local/opt/nginx/conf/localhost-key.pem \
  -cert-file /home/ubuntu/.local/opt/nginx/conf/localhost.pem \
  localhost
