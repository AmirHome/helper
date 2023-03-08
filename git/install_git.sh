#!/bin/bash

# Update package list
sudo apt update -y

# Install git
sudo apt install git -y  

# Verify git installation
git --version

git config --global user.email "amir.email@yahoo.com"
git config --global user.name "AmirHome"
