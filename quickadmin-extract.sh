#!/usr/bin/env bash

USERNAME=`whoami`;
BASEDIR=$(dirname "$0")
VHOSTDIR=$HOME/data/Codes/vhosts
CURRENT=$VHOSTDIR/Erkan/"hibes_admin"

cd "$CURRENT" > /dev/null 2>&1 || { echo "Make Directory $CURRENT"; mkdir $CURRENT; cd "$CURRENT";}
echo $PWD

# echo "Remove All files except "
# rm -rf * .*
# rsync -a ../hibes_admin/ ../"hibes_admin_copy"

git checkout quickadmin

shopt -s extglob
rm -rf !(".env"|".env.quickadmin"|".git"|".idea"|docker*|app)
rm -rf ./app/!(Helpers)

echo "Unzip .. dev-admin-d640f2cf2da7bb64.zip"
unzip -o $HOME/Downloads/dev-admin-d640f2cf2da7bb64.zip -d ./ > /dev/null 2>&1

git status

cp .env.quickadmin .env
composer install
php artisan migrate:fresh --seed
php artisan key:generate
php artisan storage:link

echo "git checkout master && git merge quickadmin --no-commit --no-ff"