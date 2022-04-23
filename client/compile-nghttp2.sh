#!/usr/bin/env bash

set -exo pipefail

git clone --depth 1 -b OpenSSL_1_1_1n+quic https://github.com/quictls/openssl

sudo apt update
sudo apt-get install -y g++ make binutils autoconf automake autotools-dev libtool pkg-config \
  zlib1g-dev libcunit1-dev libssl-dev libxml2-dev libev-dev libevent-dev libjansson-dev \
  libc-ares-dev libjemalloc-dev libsystemd-dev \
  cython python3-dev python-setuptools

echo "========== Compile openssl with QUIC support ============"
cd openssl
./config --prefix=$PWD/build --openssldir=/etc/ssl
make -j$(nproc)
make install_sw
cd ..


echo "========== Compile nghttp3 ============"
git clone --depth 1 -b v0.2.0 https://github.com/ngtcp2/nghttp3
cd nghttp3
autoreconf -i
./configure --prefix=$PWD/build --enable-lib-only
make -j$(nproc)
make install
cd ..

echo "========== Compile ngtcp2 ============"
git clone --depth 1 -b v0.3.0 https://github.com/ngtcp2/ngtcp2
cd ngtcp2
autoreconf -i
./configure --prefix=$PWD/build --enable-lib-only \
    PKG_CONFIG_PATH="$PWD/../openssl/build/lib/pkgconfig"
make -j$(nproc)
make install
cd ..

echo "========== Compile nghttp2 with QUIC support ============"
git clone --depth 1 https://github.com/nghttp2/nghttp2
cd nghttp2
autoreconf -i
./configure --enable-http3 --enable-app --disable-python-bindings PKG_CONFIG_PATH="$PWD/../openssl/build/lib/pkgconfig:$PWD/../nghttp3/build/lib/pkgconfig:$PWD/../ngtcp2/build/lib/pkgconfig" LDFLAGS="$LDFLAGS -Wl,-rpath,$PWD/../openssl/build/lib"
make -j$(nproc)
cd ..

# "install" it
sudo ln -s /home/ubuntu/nghttp2/src/h2load /usr/local/bin/h2load
