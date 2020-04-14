#! /bin/bash

pacman -S --noconfirm dhcpcd grub xorg sudo os-prober mtools
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
passwd

# Create new user
useradd -U wheel,uucp,video,audio,storage,games,input,optical tajo48
echo "%wheel ALL=(ALL) ALL $(cat /etc/sudoers)" > /etc/sudoers


# Install bootloader
mkdir /boot/grub
grub-install --target=i386-pc /dev/sda --boot-directory=/mnt/boot
grub-mkconfig -o /boot/grub/grub.cfg
