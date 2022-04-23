#!/usr/bin/env nix-shell
#!nix-shell shell.nix
#!nix-shell -i bash

set -exou pipefail

# Run iperf on both udp and tcp - throughput and ping measurements.
nohup iperf -s -p 6969 &>/dev/null &
nohup iperf -s -u -p 6969 &>/dev/null &
