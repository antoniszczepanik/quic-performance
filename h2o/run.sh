#!/usr/bin/env bash

sudo apt-get install -y certbot
sudo certbot certonly -n --standalone --email szczepanik.antoni@gmail.com --agree-tos --domains h2o.antoniszczepanik.com
# Start h2o
sudo /usr/local/bin/h2o -c h2o.config -m daemon
