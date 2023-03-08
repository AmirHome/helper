#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

gunzip < $BASEDIR/mysql_backup.sql.gz | mysql -u root -p123


