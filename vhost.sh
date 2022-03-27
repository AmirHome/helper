#!/usr/bin/env bash

### Example 
### installer.sh domain path
### if you use larave, path should be to use /public
### installer.sh amirhome "Amir/amirhome/public" real path is /var/www/vhosts/..


VPATH=$1
if [ -z $1 ]
then
	echo "ServerName is Required"
	exit
fi


if ! grep -q "127.0.0.1 $1.loc" /etc/hosts; then
  echo "127.0.0.1 $1.loc" | sudo tee -a /etc/hosts
fi


sudo rm -rf /etc/apache2/sites-enabled/$1.loc.conf


if [ ! -z "$2" ]
then
    VPATH="$2";
fi


sudo tee -a /etc/apache2/sites-enabled/$1.loc.conf > /dev/null <<EOT
<VirtualHost *:80>
	ServerName $1.loc
	DocumentRoot $HOME/Codes/vhosts/$VPATH
	SetEnv MAGE_MODE developer
	<Directory "$HOME/Codes/vhosts/$VPATH/">
		AllowOverride All
		Order allow,deny
		Allow from all
	</Directory>
</VirtualHost>
EOT


sudo systemctl restart apache2;

echo "Enjoying http://$1.loc , call from $HOME/Codes/vhosts/$VPATH"