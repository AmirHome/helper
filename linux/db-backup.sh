#!/usr/bin/env bash

# Backup MySQL
mysqldump -u root -p123 --all-databases | gzip > ./Dropbox/Helper/linux/mysql_backup.sql.gz
