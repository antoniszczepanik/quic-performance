#!/usr/bin/env bash

sudo apt-get update && sudo apt-get install -y certbot
sudo certbot certonly -n --standalone --email szczepanik.antoni@gmail.com --agree-tos --domains litespeed.antoniszczepanik.com

sudo /usr/local/lsws/bin/lswsctrl start
