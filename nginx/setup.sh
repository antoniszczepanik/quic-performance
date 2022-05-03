#!/usr/bin/env bash

# A wrapper script for setting up nginx server.

echo "set -o vi" >> ~/.profile # First things first.
./install-nix.sh
mkdir /home/ubuntu/data
echo "<p> Hello, World! </p>" > /home/ubuntu/data/index.html
head -c 1G /dev/urandom > /home/ubuntu/data/1g.txt
source ~/.profile # Make sure nix is in the path.

# Increase UDP recieve  buffer sizes.
sudo sysctl -w net.core.rmem_max=21299200
sudo sysctl -w net.core.rmem_default=21299200

./install-nginx.sh
