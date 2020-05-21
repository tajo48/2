#! /bin/bash

#programs
pacman -S --noconfirm alsa-utils netctl grub os-prober mtools dialog wpa_supplicant dhcpcd vim git make alsa-firmware wget xorg-server pulseaudio xorg-xinit curl tar libxft ranger fakeroot binutils patch pkgconf base-devel htop
#obs-studio

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

# Set root passwd
echo -en "root\nroot" | passwd

# Useradd,internet and sudo 
sed -i '/%wheel ALL=(ALL) ALL/s/^#//g' /etc/sudoers
systemctl enable dhcpcd
useradd -m tajo48
echo -en "pass\npass" | passwd tajo48
usermod -aG wheel,audio,video,optical,storage,users tajo48

# Install bootloader
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

#XMONAD TRY
pacman -S --noconfirm xmonad gnome gnome-extra

#lightdm-gtk-greeter
pacman -S --noconfirm lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
systemctl enable lightdm -f

mkdir /home/tajo48/suckless
mkdir /home/tajo48/suckless/photos
wget https://raw.githubusercontent.com/tajo48/2/master/wallpaper.jpg -O /home/tajo48/suckless/wallpaper.jpg

#SUDO
sed -i '/%wheel ALL=(ALL) ALL/s/^#//g' /etc/sudoers
#echo "feh --bg-fill /home/tajo48/photos/wallpaper.jpg
#setxkbmap -layout 'pl'" >> ~/.xprofile
#replace with ~/.xmonad
pacman -S --noconfirm feh firefox rxvt-unicode neofetch

#download 
cd /home/tajo48/suckless
git clone https://git.suckless.org/st/
git clone https://git.suckless.org/dmenu/

#wgetpatch (temporary)
cd /home/tajo48/suckless/dmenu
wget https://tools.suckless.org/dmenu/patches/center/dmenu-center-4.8.diff
wget https://tools.suckless.org/dmenu/patches/border/dmenu-border-4.9.diff

#patch (temporary)
patch < dmenu-center-4.8.diff
patch < dmenu-border-4.9.diff
sed -i '/static unsigned int lines/ s/0/1/' /home/tajo48/suckless/dmenu/config.def.h
cat /home/tajo48/suckless/dmenu/config.def.h
read -p "Press enter to continue"

#makekpkg
cd /home/tajo48/suckless/st
make clean install
cd /home/tajo48/suckless/dmenu
make clean install

cd
cat .xprofile
### Alacritty
