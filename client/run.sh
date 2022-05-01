#!/usr/bin/env bash

screen -dm bash -c "source ~/.profile; /home/ubuntu/run-notebook.sh; exec sh"
