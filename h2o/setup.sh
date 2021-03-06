#!/usr/bin/env bash

set -eou pipefail

sudo apt update
sudo apt install -y g++ make cmake build-essential libssl-dev binutils libtool zlib1g-dev


# Create data to serve
mkdir -p /home/ubuntu/data
echo "<p> Hello, World! </p>" > /home/ubuntu/data/index.html
head -c 1G /dev/urandom > /home/ubuntu/data/1g.txt
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
