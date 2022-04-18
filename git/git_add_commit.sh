#!/usr/bin/env bash

msg=("${@:1}")
shift;

if [ -z "$msg" ]
then
	echo -e "\033[31m Error you should use message for commit \e[0m";
	exit
fi


git add .
git commit -m"$msg"