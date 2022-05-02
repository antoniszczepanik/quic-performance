#!/usr/bin/env bash

SERVER_NAME=$1

cd terraform
IP=$(terraform output | grep $SERVER_NAME | cut -d '"' -f 2)

ssh ubuntu@$IP
