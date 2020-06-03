#!/bin/bash
#Just finished the system, no need to restore
if [ ! -d "./.system_backup" ]; then
echo "The system is the original version and does not need to be restored"
exit
fi

sudo cp -rf ./.system_backup/cmdline.txt /boot/
sudo cp -rf ./.system_backup/config.txt /boot/

if [ -f /etc/inittab ]; then
sudo rm -rf /etc/inittab
fi
if [ -f ./.system_backup/inittab ]; then
sudo cp -rf ./.system_backup/inittab  /etc
fi

if [ -f ./.have_installed ]; then
sudo rm -rf ./.have_installed
fi
if [ -f ./.system_backup/.have_installed ]; then
sudo cp -rf ./.system_backup/.have_installed ./
fi

sudo sync
sudo sync

echo "The system has been restored"
echo "now reboot"
sleep 1

sudo reboot
