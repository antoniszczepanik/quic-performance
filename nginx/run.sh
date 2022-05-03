#!/usr/bin/env bash

sudo apt-get update && sudo apt-get -y install certbot
sudo certbot certonly -n --standalone --email szczepanik.antoni@gmail.com --agree-tos --domains nginx.antoniszczepanik.com
sudo nginx
/home/ubuntu/run-iperf.sh
