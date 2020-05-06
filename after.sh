#! /bin/bash

#programs
pacman -S --noconfirm grub os-prober mtools dhcpcd vim git make wget xorg-server xorg-xinit curl tar libxft

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
echo "root pasword"
echo -en "root\nroot" | passwd

# Useradd,internet and sudo 
sed -i '/%wheel ALL=(ALL) ALL/s/^#//g' /etc/sudoers
systemctl enable dhcpcd
useradd -m tajo48
echo "user pasword"
echo -en "pass\npass" | passwd user
usermod -aG wheel,audio,video,optical,storage,users tajo48

# Install bootloader
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg


<<i3conf
#i3 wm
pacman -S --noconfirm i3-gaps feh firefox rxvt-unicode rofi neofetch termite
echo "exec i3" >> ~/.xinitrc
mkdir /root/.config
mkdir /root/.config/i3
mkdir /home/tajo48/photos
#curl https://raw.githubusercontent.com/tajo48/2/master/wallpaper.jpg -O /home/tajo48/photos/wallpaper.jpg 
wget https://raw.githubusercontent.com/tajo48/2/master/config_i3 -O ~/.config/i3/config
wget https://raw.githubusercontent.com/tajo48/2/master/wallpaper.jpg -O /home/tajo48/photos/wallpaper.jpg
#startx
i3conf

#dwm try
pacman -S --noconfirm feh firefox rxvt-unicode rofi neofetch
rm /usr/bin/makepkg
wget https://raw.githubusercontent.com/tajo48/2/master/makepkg /usr/bin/makepkg

#> /dev/null 2>&1
