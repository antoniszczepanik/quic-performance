#!/usr/bin/env bash

echo "set -o vi" > ~/.profile # First things first.
./install-nix.sh
source ~/.profile # Make sure nix is in the path.

# Increase UDP recieve  buffer sizes.
sudo sysctl -w net.core.rmem_max=21299200
sudo sysctl -w net.core.rmem_default=21299200

screen -dm bash -c "source ~/.profile; /home/ubuntu/run_notebook.sh; exec sh"
