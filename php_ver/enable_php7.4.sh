#!/usr/bin/env bash

# Enable php 7.4
sudo a2dismod php5.6
sudo a2dismod php7.0 
sudo a2dismod php8.1 

sudo a2enmod php7.4 
sudo update-alternatives --set php /usr/bin/php7.4 
sudo service apache2 restart
