#!/usr/bin/env bash

echo "set -o vi" >> ~/.profile # First things first.

./install-nix.sh

mkdir /home/ubuntu/data
echo "<p> Hello, World! </p>" > /home/ubuntu/data/index.html
head -c 1G /dev/urandom > /home/ubuntu/data/1g.txt
source ~/.profile # Make sure nix is in the path.

# Increase UDP recieve  buffer sizes.
sudo sysctl -w net.core.rmem_max=21299200
sudo sysctl -w net.core.rmem_default=21299200

wget https://github.com/caddyserver/caddy/releases/download/v2.5.0/caddy_2.5.0_linux_amd64.tar.gz
tar xf caddy_2.5.0_linux_amd64.tar.gz
sudo mv caddy /usr/local/bin/caddy
