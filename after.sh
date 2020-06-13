#! /bin/bash

#programs
pacman -S --noconfirm alsa-utils netctl mtools dialog wpa_supplicant dhcpcd vim vifm git make alsa-firmware wget xorg-server pulseaudio xorg-xinit curl tar libxft fakeroot binutils patch pkgconf base-devel xcompmgr picom htop
#pacman -S --noconfirm neofetch obs-studio blender bashtop
#pacman -S --noconfirm 


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
pacman -S --noconfirm grub efibootmgr os-prober
mkdir /boot/efi
mount /dev/sda1 /boot/efi
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
update-grub

#makepkg in root
rm /usr/bin/makepkg
wget https://raw.githubusercontent.com/tajo48/ARCH-files/master/makepkg -O /usr/bin/makepkg
chmod +x /usr/bin/makepkg

#yay 
cd /home/tajo48/suckless
git clone https://aur.archlinux.org/yay-git.git
cd /home/tajo48/suckless/yay-git
makepkg -s -i -c --noconfirm

###DWM part
#wallpaper
mkdir /home/tajo48/photos
wget https://raw.githubusercontent.com/tajo48/ARCH-files/master/photos/wallpaper.jpg -O /home/tajo48/photos/wallpaper.jpg
#dwm try
cd /home/tajo48
echo "feh --bg-fill /home/tajo48/photos/wallpaper.jpg
setxkbmap -layout 'pl'
exec dwm" >> ~/.xinitrc
pacman -S --noconfirm feh firefox rxvt-unicode
#download (almost temporary)
git clone https://git.suckless.org/dwm/
git clone https://git.suckless.org/st/
git clone https://git.suckless.org/dmenu/
###DWM
#wgetpatch (temporary)
cd /home/tajo48/dwm
wget https://dwm.suckless.org/patches/fakefullscreen/dwm-fakefullscreen-20170508-ceac8c9.diff
wget https://dwm.suckless.org/patches/pertag/dwm-pertag-6.2.diff
wget https://dwm.suckless.org/patches/uselessgap/dwm-uselessgap-6.2.diff
wget https://dwm.suckless.org/patches/movestack/dwm-movestack-6.1.diff
wget https://dwm.suckless.org/patches/scratchpad/dwm-scratchpad-6.2.diff
wget https://dwm.suckless.org/patches/centeredmaster/dwm-centeredmaster-6.1.diff


#patch (temporary)
cp dwm.c dwm.c.orig
patch < dwm-scratchpad-6.2.diff
patch < dwm-fakefullscreen-20170508-ceac8c9.diff
patch < dwm-pertag-6.2.diff
patch < dwm-uselessgap-6.2.diff
patch < dwm-movestack-6.1.diff
patch < dwm-centeredmaster-6.1.diff



###DMENU
#wgetpatch (temporary)
cd /home/tajo48/dmenu
wget https://tools.suckless.org/dmenu/patches/center/dmenu-center-4.8.diff
wget https://tools.suckless.org/dmenu/patches/border/dmenu-border-4.9.diff
#patch (temporary)
patch < dmenu-center-4.8.diff
patch < dmenu-border-4.9.diff
sed -i '/static unsigned int lines/ s/0/15/' /home/tajo48/dmenu/config.def.h

###ST
cd /home/tajo48/st
wget https://st.suckless.org/patches/alpha/st-alpha-0.8.2.diff

#patch
patch < st-alpha-0.8.2.diff

###MKPKG
#cp config.h config.def.h
#makekpkg
cd /home/tajo48/st
make clean install
cd /home/tajo48/dmenu
make clean install
cd /home/tajo48/dwm
make clean install
startx


<<com123
#Lightdm
lightdm-gtk-greeter
pacman -S --noconfirm lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
systemctl enable lightdm -f

su tajo48 << 'NO'
lightdm
NO

#conky
#pywal

com123
