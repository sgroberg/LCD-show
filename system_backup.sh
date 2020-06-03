#!/bin/bash
if [ ! -d "./.system_backup" ]; then
sudo mkdir ./.system_backup
fi

sudo rm -rf ./.system_backup/*

result=`grep -rn "^dtoverlay=" /boot/config.txt | grep ":rotate=" | tail -n 1`
if [ $? -eq 0 ]; then
str=`echo -n $result | awk -F: '{printf $2}' | awk -F= '{printf $NF}'`
if [ -f /boot/overlays/$str-overlay.dtb ]; then
sudo cp -rf /boot/overlays/$str-overlay.dtb ./.system_backup
sudo rm -rf /boot/overlays/$str-overlay.dtb
fi
if [ -f /boot/overlays/$str.dtbo ]; then
sudo cp -rf /boot/overlays/$str.dtbo ./.system_backup
sudo rm -rf /boot/overlays/$str.dtbo
fi
fi

root_dev=`grep -oPr "root=[^\s]*" /boot/cmdline.txt | awk -F= '{printf $NF}'`
sudo cp -rf /boot/config.txt ./.system_backup
sudo cp -rf /boot/cmdline.txt ./.system_backup/

sudo cp -rf ./boot/config-nomal.txt /boot/config.txt

sudo cp -rf /etc/rc.local ./.system_backup/
sudo cp -rf ./etc/rc.local-original /etc/rc.local

if [ -f /etc/inittab ]; then
sudo cp -rf /etc/inittab ./.system_backup
sudo rm -rf /etc/inittab
fi

type fbcp > /dev/null 2>&1
if [ $? -eq 0 ]; then
sudo touch ./.system_backup/have_fbcp
sudo rm -rf /usr/local/bin/fbcp
fi

if [ -f ./.have_installed ]; then
sudo cp -rf ./.have_installed ./.system_backup
sudo rm -rf ./.have_installed
fi
