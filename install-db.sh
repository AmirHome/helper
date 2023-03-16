#!/bin/bash
# Installer for InfyOm Generator

USERNAME=`whoami`;
BASEDIR=$(dirname "$0")
VHOSTDIR=$HOME/data/Codes/vhosts

projectName=$1
if [ -z $projectName ]
then
	echo -e "\033[31m Error: should set Project Name \e[0m";
	exit
fi

projectDir=${projectName//[-]/_}

mysql -uroot -p123 -e "CREATE DATABASE IF NOT EXISTS $projectDir CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

mysql -uroot -p123 -e "SHOW DATABASES;"
