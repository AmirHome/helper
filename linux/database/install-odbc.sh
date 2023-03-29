#!/usr/bin/env bash

USERNAME=`whoami`;

## Install the Microsoft ODBC driver for SQL Server
if ! [[ "18.04 20.04 22.04" == *"$(lsb_release -rs)"* ]];
then
    echo "Ubuntu $(lsb_release -rs) is not currently supported.";
    exit;
fi

sudo su
curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add -

curl https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/prod.list > /etc/apt/sources.list.d/mssql-release.list

# exit
su $USERNAME

sudo apt-get update
sudo ACCEPT_EULA=Y apt-get install -y msodbcsql18
# optional: for bcp and sqlcmd
sudo ACCEPT_EULA=Y apt-get install -y mssql-tools18
echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
source ~/.bashrc
# optional: for unixODBC development headers
sudo apt-get install -y unixodbc-dev


## PHP drivers for Microsoft SQL Server
sudo pecl install sqlsrv
sudo pecl install pdo_sqlsrv
sudo su
printf "; priority=20\nextension=sqlsrv.so\n" > /etc/php/8.2/mods-available/sqlsrv.ini
printf "; priority=30\nextension=pdo_sqlsrv.so\n" > /etc/php/8.2/mods-available/pdo_sqlsrv.ini
# exit
su $USERNAME

sudo phpenmod -v 8.2 sqlsrv pdo_sqlsrv

