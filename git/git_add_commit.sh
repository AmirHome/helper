#!/usr/bin/env bash


if [ -z $1 ]
then
	echo -e "\033[31m Error you should use message for commit \e[0m";
	exit
fi

git add .
git commit -m$1
