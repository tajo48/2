#! /bin/bash

pacman -S --noconfirm dhcpcd grub xorg os-prober mtools
# Set date time
ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
hwclock --systohc

# Set locale to en_US.UTF-8 UTF-8
echo "
en_US.UTF-8 UTF-8
pl_PL.UTF-8 UTF-8
" >> /etc/locale.gen

locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf

# Set hostname
echo "ARCH" >> /etc/hostname
echo "
127.0.0.1 localhost
::1
127.0.1.1 ARCH.localdomain  ARCH" >> /etc/hosts

# Set root password
clear
echo "root pasword"
passwd
clear

# Useradd and sudo
useradd -m tajo48
clear
echo "user pasword"
passwd tajo48
clear
usermod -aG wheel,audio,video,optical,storage tajo48

# Install bootloader
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

# Gnome
pacman -S --noconfirm gnome gnome-extra gdm
systemctl enable gdm
pacman -Syu
reboot

