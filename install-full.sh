#!/usr/bin/env bash

USERNAME=`whoami`;
BASEDIR=$(dirname "$0")
lsb_release -a

if [ $1 = "remove" ]; then
    echo "Remove All Extentions .."

	sudo apt purge php*.*\* -y
	sudo apt purge apache* -y

	sudo apt-get autoclean -y
	sudo apt-get autoremove -y

else
    echo "Installing LAMP .."
fi


sudo apt-get update -y;

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

# Change /etc/apache2/apache2.conf to new vhost path
sudo sh -c "echo '<Directory /home/$USERNAME/data/Codes/vhosts/>\n\tOptions FollowSymLinks\n\tAllowOverride All\n\tRequire all granted\n</Directory>' >> /etc/apache2/apache2.conf"


sudo apt install -y lsb-release gnupg2 ca-certificates apt-transport-https software-properties-common
sudo add-apt-repository -y ppa:ondrej/php;
sudo apt update	-y;

# Install php5.6
sudo apt-get -y install php5.6 php5.6-mcrypt php5.6-zip php5.6-xml php5.6-gd php5.6-mbstring php5.6-mysql php5.6-json php5.6-tokenizer openssl
#sudo apt-get -y install php5.6 php5.6-libc-client php5.6-pear php5.6-php-bcmath php5.6-php-bz2 php5.6-php-calendar php5.6-php-cli php5.6-php-common php5.6-php-curl php5.6-php-devel php5.6-php-fileinfo php5.6-php-fpm php5.6-php-ftp php5.6-php-gd php5.6-php-imap php5.6-php-litespeed php5.6-php-mbstring php5.6-php-mcrypt php5.6-php-mysqlnd php5.6-php-pdo php5.6-php-posix php5.6-php-sockets php5.6-php-xml php5.6-php-xmlrpc php5.6-php-zip php5.6-runtime 


# Install php7.0
sudo apt-get -y install php7.0 libapache2-mod-php7.0 php7.0-curl php7.0-json php7.0-mbstring php7.0-mysql php7.0-xml php7.0-zip php7.0-common php7.0-bcmath php7.0-mcrypt php7.0-cgi php7.0-cli php7.0-curl php7.0-dev php7.0-gd php7.0-gmp php7.0-pdo openssl 

# Install php7.1
sudo apt-get -y install php7.1 libapache2-mod-php7.1 php7.1-curl php7.1-json php7.1-mbstring php7.1-mysql php7.1-xml php7.1-zip php7.1-common php7.1-bcmath php7.1-mcrypt php7.1-cgi php7.1-cli php7.1-curl php7.1-dev php7.1-gd php7.1-gmp php7.1-pdo openssl 

# Install php7.4
# - php7.4-fpm
sudo apt-get -y install php7.4 libapache2-mod-php7.4 openssl php7.4-curl php7.4-json php7.4-mbstring php7.4-mysql php7.4-xml php7.4-zip php7.4-common php7.4-bcmath php7.4-mcrypt

# Install php 8.0
# - libapache2-mod-fcgid php8.0-fpm
sudo apt-get -y install php8.0 libapache2-mod-php8.0 php8.0-fpm php8.0-curl php8.0-dev php8.0-gd php8.0-mbstring php8.0-zip php8.0-mysql php8.0-xml;

# Install php 8.1
# - libapache2-mod-fcgid php8.1-fpm
sudo apt-get -y install php8.1 libapache2-mod-php8.1 php8.1-fpm php8.1-curl php8.1-dev php8.1-gd php8.1-mbstring php8.1-zip php8.1-mysql php8.1-xml;

# Install php 8.2
# - libapache2-mod-fcgid php8.2-fpm
# - for MsSQL php8.2-sybase [PHP.ini extension=sqlsrv.so]
sudo apt-get -y install php8.2 libapache2-mod-php8.2 php8.2-fpm php8.2-curl php8.2-dev php8.2-gd php8.2-mbstring php8.2-zip php8.2-mysql php8.2-xml php8.2-sybase;

# Enable php 5.6
bash $BASEDIR/php_ver/enable_php5.6.sh

# Enable php 7.0
bash $BASEDIR/php_ver/enable_php7.0.sh

# Enable php 7.1
bash $BASEDIR/php_ver/enable_php7.1.sh

# Enable php 7.4
bash $BASEDIR/php_ver/enable_php7.4.sh

# Enable php 8.0 
bash $BASEDIR/php_ver/enable_php8.0.sh

# Enable php 8.1
# sudo a2dismod php5.6 && 
bash $BASEDIR/php_ver/enable_php8.1.sh

# Enable php 8.2
# sudo a2dismod php5.6 && 
bash $BASEDIR/php_ver/enable_php8.2.sh

sudo a2enmod rewrite;

### Initial Codes Vhost

sudo mkdir -p $HOME/data/Codes/vhosts;
sudo chown -R $USERNAME:$USERNAME $HOME/data/Codes/;
# cd $HOME/data/Codes/vhosts;

### Customize Apache virtual host directory on home directory.
if grep -q "<Directory $HOME/data/Codes/vhosts/>" "/etc/apache2/apache2.conf"; then
	sudo tee -a /etc/apache2/apache2.conf > /dev/null <<EOT
<Directory $HOME/data/Codes/vhosts/>
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

mkdir -p $HOME/data/Codes/vhosts/$TEST_NAME
rm -rf $HOME/data/Codes/vhosts/$TEST_NAME/index.php

tee -a $HOME/data/Codes/vhosts/$TEST_NAME/index.php > /dev/null <<EOT
<?php
phpinfo();
EOT




### Mysql Permission

sudo mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH caching_sha2_password BY '123';";
sudo mysql -uroot -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '123';";

sudo mysql -uroot -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;";
sudo mysql -uroot -e "FLUSH PRIVILEGES;";


### Restore Database
bash $HOME/data/Dropbox/Helper/linux/db-restore.sh

# Restore SSH
cp -r $HOME/data/Dropbox/Helper/linux/.ssh $HOME/

# Restore VHOST
sudo cp -r $HOME/data/Dropbox/Helper/linux/sites-enabled /etc/apache2/

# Restore /etc/hosts
sudo cp $HOME/data/Dropbox/Helper/linux/hosts /etc/
sudo systemctl restart apache2

#For DBeaver users:
#Right click your connection, choose "Edit Connection"
#On the "Connection settings" screen (main screen) click on "Edit Driver Settings"
#Click on "Connection properties"
#Right click the "user properties" area and choose "Add new property"
#Add two properties: "useSSL" and "allowPublicKeyRetrieval"
#Set their values to "false" and "true" by double clicking on the "value" column


### Install Rust
echo "\nRust installing..."
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
# sudo apt install rustc -y
rustc -V


### Install Python
echo "\nPython installing..."
sudo apt-get -y install python3 python3-pip python3-dev python3-venv python3-tk python3-setuptools python3-wheel python3-apt python3-pip python3-dev python3-venv python3-tk python3-setuptools python3-wheel python3-apt
python3 --version

### Composer Install
echo "\nComposer installing..."
sudo apt-get -y install curl;
sudo curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/bin --filename=composer
mkdir -p $HOME/.composer
composer --version


## Run Git Installer
echo "\nGit installing..."
sudo bash $BASEDIR/git/install_git.sh


## Run Docker Installer
echo "\nDocker installing..."
sudo bash $BASEDIR/install_docker.sh


## Find snap or apt
## snap find xxxx
## apt-cache search xxxx
## Run Chrome Download and Installer
wget -P $HOME/Download/ https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install $HOME/Download/google-chrome-stable_current_amd64.deb -y

## Run Microsoft Edge Installer
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main"
sudo apt install microsoft-edge-stable -y

## Run Dropbox Installer
sudo apt-get install -y nautilus-dropbox

## Run TeamViewer Installer
wget -P $HOME/Download/ https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
sudo apt -y install $HOME/Download/teamviewer_amd64.deb

## Run FileZilla Download and Installer
sudo apt install filezilla -y

## Run CopyQ Text Installer
sudo apt-get install copyq -y

## Snap Install
sudo snap install postman
sudo snap install antares
sudo snap install code --classic
sudo snap install phpstorm --classic
sudo snap install android-studio --classic
sudo snap install flutter --classic
sudo snap install keepassxc