#!/usr/bin/env bash

set -exou pipefail

sh <(curl -L https://nixos.org/nix/install) --no-daemon
. /home/ubuntu/.nix-profile/etc/profile.d/nix.sh # or logout & login
