#!/usr/bin/env bash

sudo apt-get update && sudo apt-install -y install certbot
sudo certbot certonly -n --standalone --email szczepanik.antoni@gmail.com --agree-tos --domains caddy.antoniszczepanik.com
sudo caddy start
