#!/bin/bash
# Bash Menu PHP Version

BASEDIR=$(dirname "$0")

echo ""
php --version
echo ""


PS3='Please enter your choice: '
options=("php 5.6" "php 7.0" "php 7.4" "php 8.1" "Quit")
select opt in "${options[@]}"
do

    case $opt in
        "php 5.6")
            # Enable php 5.6
            bash $BASEDIR/php_ver/enable_php5.6.sh
            
            break
            ;;
        "php 7.0")
            # Enable php 7.0
            bash $BASEDIR/php_ver/enable_php7.0.sh
            
            break
            ;;
        "php 7.4")
            # Enable php 7.4
            bash $BASEDIR/php_ver/enable_php7.4.sh
            
            break
            ;;
        "php 8.1")
            #echo "you chose choice $REPLY which is $opt"
            # Enable php 8.1
            bash $BASEDIR/php_ver/enable_php8.1.sh
            
            break
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done

echo ""
php --version
