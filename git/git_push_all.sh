#!/usr/bin/env bash

USERNAME=`whoami`;
BASEDIR=$(dirname "$0")

# git remote | xargs -L1 git push --all
git remote | xargs -I % sh -c 'git push %; echo "\033[32m Pushed % \e[0m"'
