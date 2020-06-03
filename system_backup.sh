#!/bin/bash
if [ ! -d "./.system_backup" ]; then
sudo mkdir ./.system_backup
else
sudo rm -rf ./.system_backup/*
fi

root_dev=`grep -oPr "root=[^\s]*" /boot/cmdline.txt | awk -F= '{printf $NF}'`
sudo cp -rf /boot/config.txt ./.system_backup
sudo cp -rf /boot/cmdline.txt ./.system_backup/

if [ -f /etc/inittab ]; then
sudo cp -rf /etc/inittab ./.system_backup
sudo rm -rf /etc/inittab
fi

if [ -f ./.have_installed ]; then
sudo cp -rf ./.have_installed ./.system_backup
sudo rm -rf ./.have_installed
fi
