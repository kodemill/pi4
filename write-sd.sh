#!/bin/bash
set -euo pipefail

source ./util.sh

# https://archlinuxarm.org/platforms/armv8/broadcom/raspberry-pi-4
warn "Raspberry Pi 4 install script, use it at your own risk!"

(( EUID != 0 )) && fail "You must be root to run this script." && exit 1

USB_DEV=$(lsblk -pnd -I 8 -o name,tran,size | grep usb | awk '{print $1}')
[[ -z ${USB_DEV} ]] && fail "Could not find suitable usb!" && exit 1

PART_BOOT="${USB_DEV}1"
PART_ROOT="${USB_DEV}2"
WORKDIR='archlinux-arm.tmp'
# MOUNT_ROOT_DIR="${WORKDIR}/mount"

read -r -p "The device ${USB_DEV} will be wiped! Continue? [yY]:" WIPE_OK
[[ ! $WIPE_OK =~ ^[Yy]$ ]] && exit 1

umount ${USB_DEV} ${PART_BOOT} ${PART_ROOT} || true

info "Partitioning $USB_DEV..."
parted --script "${USB_DEV}" \
  mklabel gpt \
  mkpart primary fat32 1MiB 100MiB \
  set 1 boot on \
  mkpart primary ext4 100MiB 100% #1>/dev/null

info "Creating mount directory ${WORKDIR}"
mkdir -p "${WORKDIR}"
pushd "${WORKDIR}"

info "Create and mount the FAT filesystem: ${PART_BOOT}"
mkfs.vfat "${PART_BOOT}" -F 32 -n BOOT #1>/dev/null
mkdir boot
mount "${PART_BOOT}" boot

info "Create and mount the ext4 filesystem: ${PART_ROOT}"
mkfs.ext4 "${PART_ROOT}" -F -L root #1>/dev/null
mkdir root
mount "${PART_ROOT}" root

info "Download and extract the root filesystem"
arch_rpi="ArchLinuxARM-rpi-4-latest.tar.gz"
[[ ! -f "${arch_rpi}" ]] && wget -O "${arch_rpi}" http://os.archlinuxarm.org/os/ArchLinuxARM-rpi-4-latest.tar.gz 
bsdtar -xpf "${arch_rpi}" -C root
sync

info "Move boot files to the first partition"
mv root/boot/* boot

info "Unmount the two partitions"
umount boot root

info "Cleaning up..."
rm -rf boot root

popd
info "Done."
