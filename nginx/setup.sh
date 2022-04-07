#!/usr/bin/env bash

# A wrapper script for setting up nginx server.

echo "set -o vi" > ~/.profile # First things first.
./install-nix.sh
source ~/.profile # Make sure nix is in the path.
./install-nginx.sh

