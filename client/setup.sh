#!/usr/bin/env bash

echo "set -o vi" > ~/.profile # First things first.
./install-nix.sh
source ~/.profile # Make sure nix is in the path.

screen -dm bash -c "source ~/.profile; /home/ubuntu/run_notebook.sh; exec sh"
