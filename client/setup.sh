#!/usr/bin/env bash

echo "set -o vi" > ~/.profile # First things first.
./install-nix.sh
source ~/.profile # Make sure nix is in the path.
./run_notebook.sh
