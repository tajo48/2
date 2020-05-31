#! /bin/bash

# Font
loadkeys pl
setfont Lat2-Terminus16.psfu.gz -m 8859-2

# Setup the disk and partitions

# Wipefs

# Mkfs

# Set up time
timedatectl set-ntp true

# Initate pacman keyring
<<com
pacman-key --init
pacman-key --populate archlinux
pacman-key --refresh-keys
com

# Mount the partitions
mount /dev/sda2 /mnt
mkdir /mnt/boot
swapon /dev/sda1

# Install Arch Linux
pacstrap /mnt base linux pacman sudo

# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Copy post-install system cinfiguration script to new /root
    wget https://raw.githubusercontent.com/tajo48/2/uefi/after.sh -O /mnt/root/after.sh
    chmod +x /mnt/root/after.sh

# Chroot into new system
arch-chroot /mnt /root/after.sh

