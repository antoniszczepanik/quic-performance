#!/usr/bin/env nix-shell
#!nix-shell shell.nix
#!nix-shell -i bash

set -exou pipefail

PORT=8080

echo "Running jupyter notebook at port $PORT..."
python3 -m jupyterlab --no-browser --port $PORT --ip 0.0.0.0 --ServerApp.token='' --ServerApp.password='' &
