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
projectPATH=$VHOSTDIR/$projectDir

bash $BASEDIR/vhost.sh $projectName $projectDir/public 


composer create-project laravel/laravel $projectPATH \
   && cd $projectPATH

sed -i "s/APP_NAME=Laravel/APP_NAME=$projectName/g" .env
sed -i "s/APP_URL=http:\/\/localhost/APP_URL=$projectName.loc/g" .env
sed -i "s/DB_DATABASE=laravel/DB_DATABASE=$projectDir/g" .env
sed -i "s/DB_PASSWORD=/DB_PASSWORD=123/g" .env

# mysql -uroot -p123 -e "CREATE DATABASE IF NOT EXISTS $projectDir CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
bash $BASEDIR/install-db.sh $projectDir 

php artisan key:generate
php artisan migrate:fresh --seed
php artisan optimiz:clear
