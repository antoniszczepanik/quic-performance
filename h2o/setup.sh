#!/usr/bin/env bash

set -eou pipefail

# Get binary source for mkcert
wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64
sudo mv mkcert-v1.4.3-linux-amd64 /usr/local/bin/mkcert
chmod +x /usr/local/bin/mkcert

sudo apt update
sudo apt install -y g++ make cmake build-essential libssl-dev binutils libtool zlib1g-dev


# Create data to serve
mkdir -p /home/ubuntu/data
echo "<p> Hello, World! </p>" > /home/ubuntu/data/index.html
head -c 2G /dev/urandom > /home/ubuntu/data/2g.txt
source ~/.profile # Make sure nix is in the path.

# Increase UDP recieve  buffer sizes.
sudo sysctl -w net.core.rmem_max=21299200
sudo sysctl -w net.core.rmem_default=21299200

# Clone and build h2o
if [ ! -d h2o ] ; then
    git clone --depth 1 --recurse-submodules https://github.com/h2o/h2o.git
fi
cd h2o
mkdir -p build
cd build
cmake ..
make
sudo git config --global --add safe.directory /home/ubuntu/h2o
sudo make install
cd ../..

# Create a certificate
mkcert \
  -key-file /home/ubuntu/localhost-key.pem \
  -cert-file /home/ubuntu/localhost.pem \
  localhost

# Start h2o
sudo /usr/local/bin/h2o -c h2o.config
