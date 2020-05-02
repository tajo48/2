#! /bin/bash

pacman -S --noconfirm grub os-prober mtools dhcpcd vim git make
# Set date time
ln -sf /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
hwclock --systohc

# Set locale to en_US.UTF-8 UTF-8
echo "en_US.UTF-8 UTF-8
pl_PL.UTF-8 UTF-8" >> /etc/locale.gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
locale-gen

# Set hostname
echo "ARCH" >> /etc/hostname
echo "
127.0.0.1	localhost
::1		localhost
127.0.1.1	ARCH" >> /etc/hosts

# Set root password
clear
echo "root pasword"
passwd
clear

# Useradd,internet and sudo 
sed -i '/%wheel ALL=(ALL) ALL/s/^#//g' /etc/sudoers
systemctl enable dhcpcd
useradd -m tajo48
clear
echo "user pasword"
passwd tajo48
clear
usermod -aG wheel,audio,video,optical,storage,users tajo48

# Install bootloader
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

<<com1
# Gnome
pacman -S --noconfirm gnome gnome-extra gdm
systemctl enable gdm
pacman -Syu
com1

#DWM
pacman -S --noconfirm xorg-xinit xorg fontconfig freetype2
cd /usr/src
git clone git://git.suckless.org/dwm
git clone git://git.suckless.org/st
git clone git://git.suckless.org/dmenu
cd /usr/src/dmenu
make clean install
cd /usr/src/dwm
make clean install
cd /usr/src/st
make clean install
#echo "exec dwm $(cat .xinitrc)" > .xinitrc
#startx
