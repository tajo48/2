#! /bin/bash

#programs
pacman -S --noconfirm alsa-utils netctl grub os-prober mtools dialog wpa_supplicant dhcpcd vim vifm git make alsa-firmware wget xorg-server pulseaudio xorg-xinit curl tar libxft fakeroot binutils patch pkgconf base-devel htop
#pacman -S --noconfirm neofetch obs-studio blender bashtop
#pacman -S --noconfirm gnome gnome-extra


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
systemctl enable dhcpcd
useradd -m tajo48
echo -en "root\nroot" | passwd tajo48
usermod -aG wheel,audio,video,optical,storage,users tajo48
sed -i '/%wheel ALL=(ALL) NOPASSWD: ALL/s/^#//g' /etc/sudoers

# Install bootloader
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

#makepkg in root
rm /usr/bin/makepkg
wget https://raw.githubusercontent.com/tajo48/ARCH-linux-install-script/master/makepkg -O /usr/bin/makepkg
chmod +x /usr/bin/makepkg

#Xmonad
pacman -S --noconfirm xmobar firefox feh termite xmonad xmonad-contrib conky
#https://aur.archlinux.org/cgit/aur.git/snapshot/brave.tar.gz

#xmonad config
#mkdir /home/tajo48/.xmonad
wget https://raw.githubusercontent.com/tajo48/ARCH-linux-install-script/master/xmonad.hs -O /home/tajo48/.xmonad/xmonad.hs

#lightdm-gtk-greeter
#pacman -S --noconfirm lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
#systemctl enable lightdm -f

#GDM
pacman -S --noconfirm gdm
systemctl enable gdm

mkdir /home/tajo48/suckless
mkdir /home/tajo48/suckless/photos
wget https://raw.githubusercontent.com/tajo48/2/master/wallpaper.jpg -O /home/tajo48/suckless/photos/wallpaper.jpg

#yay 
cd /home/tajo48/suckless
git clone https://aur.archlinux.org/yay-git.git
cd /home/tajo48/suckless/yay-git
makepkg -s -i -c --noconfirm

#dmenu
cd /home/tajo48/suckless
git clone https://git.suckless.org/dmenu/
cd /home/tajo48/suckless/dmenu
wget https://tools.suckless.org/dmenu/patches/center/dmenu-center-4.8.diff
wget https://tools.suckless.org/dmenu/patches/border/dmenu-border-4.9.diff
patch < dmenu-center-4.8.diff
patch < dmenu-border-4.9.diff
sed -i '/static unsigned int lines/ s/0/15/' /home/tajo48/suckless/dmenu/config.def.h

#make clean install
cd /home/tajo48/suckless/dmenu
make clean install

#echo "feh --bg-fill /home/tajo48/photos/wallpaper.jpg
#setxkbmap -layout 'pl'" >> ~/.xprofile
#replace with ~/.xmonad
