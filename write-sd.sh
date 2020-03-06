#!/bin/bash

# Raspberry Pi 4 install script
# https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-4

usb_dev=$(lsblk -pnd -I 8 -o name,tran,size | grep usb | awk '{print $1}')

if [ usb_dev -eq]

mkdir build
cd build



echo "Creating partitions on $usb_dev"
# https://superuser.com/a/984637
sed -e 's/\s*\([\+0-9a-zA-Z]*\).*/\1/' << EOF | fdisk "$usb_dev" --wipe always
  o # clear the in memory partition table
  n # new partition
  p # primary partition
  1 # partition number 1
    # default - start at beginning of disk
  +100M # 100 MB boot parttion
  t # type
  c # W95 FAT32 (LBA)
  n # new partition
  p # primary partition
  2 # partion number 2
    # default, start immediately after preceding partition
    # default, extend partition to end of disk
  w # write the partition table
  q # and we're done
EOF

echo "Create and mount the FAT filesystem"
mkfs.vfat "${usb_dev}1"
mkdir boot
mount "${usb_dev}1" boot

echo "Create and mount the ext4 filesystem"
mkfs.ext4 "${usb_dev}2"
mkdir root
mount "${usb_dev}2" root

# echo "Download and extract the root filesystem"
# wget http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-4-latest.tar.gz
# bsdtar -xpf ArchLinuxARM-rpi-4-latest.tar.gz -C root
# sync
