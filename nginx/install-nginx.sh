#!/usr/bin/env nix-shell
#!nix-shell shell.nix
#!nix-shell -i bash

set -exou pipefail

# Download nginx
wget https://hg.nginx.org/nginx-quic/archive/55b38514729b.tar.gz --no-check-certificate
tar xf /home/ubuntu/55b38514729b.tar.gz

# Configure & build
cd /home/ubuntu/nginx-quic-55b38514729b
./auto/configure --prefix="/home/ubuntu/.nginx" \
                 --with-http_v3_module       \
                 --with-http_v2_module       \
                 --with-stream_quic_module   \
                 --with-cc-opt="-I../boringssl/include"     \
                 --with-ld-opt="-L../boringssl/build/ssl    \
                                -L../boringssl/build/crypto"

make
make install

sudo mv /home/ubuntu/nginx-quic-55b38514729b/objs/nginx /usr/local/bin/nginx
