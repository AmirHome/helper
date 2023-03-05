#!/usr/bin/env bash

# Backup to USB Drive
# Show available block devices
lsblk

# Prompt the user to enter the device name
read -p "Enter the device name for the USB drive (e.g. sdb): " device_name

# Check if the device name is empty
if [[ -z $device_name ]]; then
    echo "Device name cannot be empty."
    exit 1
fi

# Check if the device exists
# if ! lsblk | grep -q $device_name; then
#     echo "Device $device_name not found."
#     exit 1
# fi

# Check if the device is mounted
# if grep -q "$device_name" /proc/mounts; then
#     echo "Device $device_name is already mounted."
#     exit 1
# fi

# Mount the device
# echo "Mounting $device_name to /mnt/usb..."
# sudo mount $device_name /mnt/usb

# Copy the home directory to the USB drive
echo "Copying home directory to $device_name ..."
# rsync -avz --progress /home/$USER/ "$device_name"/backup/

echo "removing log files ..."
sudo rm -rf /home/$USER/Codes/*.log

# Backup ssh keys
sudo cp -r ~/.ssh/ ./Dropbox/Helper/linux/

# Backup .bashrc
sudo cp ~/.bashrc ./Dropbox/Helper/linux/

# Backup /etc/hosts
sudo cp /etc/hosts ./Dropbox/Helper/linux/

# Backup /etc/apache2/sites-enabled
sudo cp -r /etc/apache2/sites-enabled ./Dropbox/Helper/linux/

# Backup MySQL
# mysqldump -u root -p123 --all-databases | gzip > ./Dropbox/Helper/linux/mysql_backup.sql.gz
sudo ./Dropbox/Helper/linux/db-backup.sh

# Export to External Drive


sudo mkdir $device_name/backup/
# sudo mkdir $device_name/backup/Codes/
# sudo mkdir $device_name/backup/Documents/
# sudo mkdir $device_name/backup/Dropbox/
# sudo mkdir $device_name/backup/Music/
# sudo mkdir $device_name/backup/Pictures/
# sudo mkdir $device_name/backup/Videos/
# sudo mkdir $device_name/backup/YandexDisk/


echo "Copying Codes to $device_name ..."
# sudo cp -r /home/$USER/Codes $device_name/backup/Codes/
sudo tar -czvf $device_name/backup/Codes.tar.gz /home/$USER/Codes

echo "Copying Documents to $device_name ..."
# sudo cp -r /home/$USER/Documents $device_name/backup/Documents/
sudo tar -czvf $device_name/backup/Documents.tar.gz /home/$USER/Documents

echo "Copying Downloads to $device_name ..."
# sudo cp -r /home/$USER/Dropbox $device_name/backup/Dropbox/
sudo tar -czvf $device_name/backup/Dropbox.tar.gz /home/$USER/Dropbox

echo "Copying Music to $device_name ..."
# sudo cp -r /home/$USER/Music $device_name/backup/Music/
sudo tar -czvf $device_name/backup/Music.tar.gz /home/$USER/Music

echo "Copying Pictures to $device_name ..."
# sudo cp -r /home/$USER/Pictures $device_name/backup/Pictures/
sudo tar -czvf $device_name/backup/Pictures.tar.gz /home/$USER/Pictures

echo "Copying Videos to $device_name ..."
# sudo cp -r /home/$USER/Videos $device_name/backup/Videos/
sudo tar -czvf $device_name/backup/Videos.tar.gz /home/$USER/Videos

echo "Copying YandexDisk to $device_name ..."
# sudo cp -r /home/$USER/YandexDisk $device_name/backup/YandexDisk/
sudo tar -czvf $device_name/backup/YandexDisk.tar.gz /home/$USER/YandexDisk


echo "Done."
