#!/bin/bash
# Bash Menu PHP Version

PS3='Please enter your choice: '
options=("php 5.6" "php 7.0" "php 7.4" "php 8.0" "Quit")
select opt in "${options[@]}"
do

    case $opt in
        "php 5.6")
            # Enable php 5.6
            sudo a2dismod php5.6 && sudo a2dismod php7.0 && sudo a2dismod php7.4 && sudo a2dismod php8.0 && sudo a2enmod php5.6 && sudo update-alternatives --set php /usr/bin/php5.6 && sudo service apache2 restart
            
            break
            ;;
        "php 7.0")
            # Enable php 7.0
            sudo a2dismod php5.6 && sudo a2dismod php7.0 && sudo a2dismod php7.4 && sudo a2dismod php8.0 && sudo a2enmod php7.0 && sudo update-alternatives --set php /usr/bin/php7.0 && sudo service apache2 restart
            
            break
            ;;
        "php 7.4")
            # Enable php 7.4
            sudo a2dismod php5.6 && sudo a2dismod php7.0 && sudo a2dismod php7.4 && sudo a2dismod php8.0 && sudo a2enmod php7.4 && sudo update-alternatives --set php /usr/bin/php7.4 && sudo service apache2 restart
            
            break
            ;;
        "php 8.0")
            #echo "you chose choice $REPLY which is $opt"
            # Enable php 8.0
            sudo a2dismod php5.6 && sudo a2dismod php7.0 && sudo a2dismod php7.4 && sudo a2dismod php8.0 && sudo a2enmod php8.0 && sudo update-alternatives --set php /usr/bin/php8.0 && sudo service apache2 restart
            
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