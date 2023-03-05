#!/bin/bash

sudo apt-get autoremove --purge

sudo rm -rf ~/.cache/thumbnails/*

sudo apt-get clean

sudo du -sh ~/.cache/thumbnails
sudo du -sh /var/cache/apt/

sudo apt-get update

cat /etc/os-release