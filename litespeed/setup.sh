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

wget https://openlitespeed.org/packages/openlitespeed-1.7.15.tgz
tar xf openlitespeed-1.7.15.tgz
mv /home/ubuntu/ols.conf /home/ubuntu/openlitespeed/ols.conf
sudo ./openlitespeed/install.sh
sudo mv /home/ubuntu/httpd_config.conf /usr/local/lsws/conf/httpd_config.conf
sudo mv /home/ubuntu/vhconf.conf /usr/local/lsws/conf/vhosts/Example/vhconf.conf

