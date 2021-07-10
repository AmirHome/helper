#!/usr/bin/env bash

### Example 
### installer.sh domain path
### if you use larave, path should be to use /public
### installer.sh amirhome "Amir/amirhome/public" real path is /var/www/vhosts/..

echo "127.0.0.1 $1.loc" | sudo tee -a /etc/hosts;

sudo rm -rf /etc/apache2/sites-enabled/$1.loc.conf

path=$1
if [ ! -z "$2" ]
then
      path=$2
fi


sudo tee -a /etc/apache2/sites-enabled/$1.loc.conf > /dev/null <<EOT
<VirtualHost *:80>
	ServerName $1.loc
	DocumentRoot /var/www/vhosts/$path
	SetEnv MAGE_MODE developer
	<Directory "/var/www/vhosts/$path/">
		AllowOverride All
		Order allow,deny
		Allow from all
	</Directory>
</VirtualHost>
EOT

sudo systemctl restart apache2;
