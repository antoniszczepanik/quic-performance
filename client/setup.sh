#!/usr/bin/env bash

echo "set -o vi" > ~/.profile # First things first.
./install-nix.sh
source ~/.profile # Make sure nix is in the path.
nohup ./run_notebook.sh &>/dev/null &
