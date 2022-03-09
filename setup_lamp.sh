#!/usr/bin/env bash

USERNAME=`whoami`;
BASEDIR=$(dirname "$0")

if [ $1 = "remove" ]; then
    echo "Remove All Extentions .."

	sudo apt purge php*.*\* -y
	sudo apt purge apache* -y

	sudo apt-get autoclean -y
	sudo apt-get autoremove -y

else
    echo "Install .."
fi


sudo apt-get update;

sudo apt-get -y install apache2;

sudo sed -i "s/Options Indexes FollowSymLinks/Options FollowSymLinks/" /etc/apache2/apache2.conf;
sudo sed -i "s/www-data/$USERNAME/" /etc/apache2/envvars;

sudo systemctl stop apache2.service;
sudo systemctl start apache2.service;
sudo systemctl enable apache2.service;

sudo apt-get -y install mysql-server mysql-client;

sudo systemctl stop mysql.service;
sudo systemctl start mysql.service;
sudo systemctl enable mysql.service;

sudo systemctl restart mysql.service;

sudo apt-get -y install software-properties-common;
sudo add-apt-repository -y ppa:ondrej/php;
sudo apt update;

# Install php5.6
# sudo apt-get -y install php5.6 php5.6-mcrypt php5.6-zip php5.6-xml php5.6-gd php5.6-mbstring php5.6-mysql

# Install php7.0
sudo apt-get -y install php7.0 libapache2-mod-php7.0 php7.0-cgi php7.0-cli php7.0-common php7.0-curl php7.0-dev php7.0-gd php7.0-gmp php7.0-mysql php7.0-pdo php7.0-xml

# Install php7.4
# - php7.4-fpm
sudo apt-get -y install php7.4 libapache2-mod-php7.4 openssl php7.4-curl php7.4-json php7.4-mbstring php7.4-mysql php7.4-xml php7.4-zip php7.4-common php7.4-bcmath

# Install php 8.1
# - libapache2-mod-fcgid php8.1-fpm
sudo apt-get -y install php8.1 libapache2-mod-php8.1 php8.1-fpm php8.1-curl php8.1-dev php8.1-gd php8.1-mbstring php8.1-zip php8.1-mysql php8.1-xml;

# Enable php 5.6
# sudo a2enmod php5.6 && sudo a2dismod php7.0 && sudo a2dismod php7.4 && a2dismod php8.1 && sudo update-alternatives --set php /usr/bin/php5.6 && sudo service apache2 restart

# Enable php 7.0
#sudo a2dismod php5.6
sudo a2dismod php7.4
sudo a2dismod php8.1 

sudo a2enmod php7.0
sudo update-alternatives --set php /usr/bin/php7.0
sudo service apache2 restart

# Enable php 7.4
# sudo a2dismod php5.6 && 
sudo a2dismod php7.0 
sudo a2dismod php8.1 

sudo a2enmod php7.4 
sudo update-alternatives --set php /usr/bin/php7.4 
sudo service apache2 restart

# Enable php 8.1
# sudo a2dismod php5.6 && 
sudo a2dismod php7.0 
sudo a2dismod php7.4 

sudo a2enmod php8.1 
sudo update-alternatives --set php /usr/bin/php8.1 
sudo service apache2 restart

sudo a2enmod rewrite;

### Initial Codes Vhost

sudo mkdir -p $HOME/Codes/vhosts;
sudo chown -R $USERNAME:$USERNAME $HOME/Codes/;
# cd $HOME/Codes/vhosts;

### Customize Apache virtual host directory on home directory.
if grep -q "<Directory $HOME/Codes/vhosts/>" "/etc/apache2/apache2.conf"; then
	sudo tee -a /etc/apache2/apache2.conf > /dev/null <<EOT
<Directory $HOME/Codes/vhosts/>
	Options FollowSymLinks
	AllowOverride None
	Require all granted
</Directory>
EOT
	sudo systemctl restart apache2;
fi


###    Create Virtual Host for test

TEST_NAME=test

## Run helper vhost
bash $BASEDIR/vhost.sh $TEST_NAME

mkdir -p $HOME/Codes/vhosts/$TEST_NAME
rm -rf $HOME/Codes/vhosts/$TEST_NAME/index.php

tee -a $HOME/Codes/vhosts/$TEST_NAME/index.php > /dev/null <<EOT
<?php
phpinfo();
EOT




### Mysql Permission

sudo mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY '123';";
sudo mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123';";

sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;";
sudo mysql -uroot -e "FLUSH PRIVILEGES;";

#For DBeaver users:
#Right click your connection, choose "Edit Connection"
#On the "Connection settings" screen (main screen) click on "Edit Driver Settings"
#Click on "Connection properties"
#Right click the "user properties" area and choose "Add new property"
#Add two properties: "useSSL" and "allowPublicKeyRetrieval"
#Set their values to "false" and "true" by double clicking on the "value" column


### Composer Install
sudo apt-get -y install curl;
sudo curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/bin --filename=composer
mkdir -p $HOME/.composer
composer --version


## Run Docker Installer
bash $BASEDIR/install_docker.sh