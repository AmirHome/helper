#!/bin/bash


USERNAME=`whoami`;

## Requirment
ln -s /data $HOME/data
sudo chown -R $USERNAME:$USERNAME $HOME/data
sudo chmod -R 700 $HOME/data
