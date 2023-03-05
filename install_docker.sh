#!/bin/sh

USERNAME=`whoami`;
BASEDIR=$(dirname "$0")

# Server information
lsb_release -a
service --status-all

# How To Install And Run Docker On Ubuntu 20.04 LTS
sudo apt update -y

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update -y

sudo apt install docker-ce docker-ce-cli containerd.io -y
sudo usermod -a -G docker $USERNAME

docker -v

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/bin/docker-compose
sudo chmod +x /usr/bin/docker-compose

docker-compose -v

