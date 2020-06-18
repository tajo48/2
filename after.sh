#! /bin/bash

#programs
pacman -S --noconfirm alsa-utils netctl mtools dialog wpa_supplicant dhcpcd git neofetch mc xclip
pacman -S --noconfirm obs-studio blender bashtop calc virtualbox virtualbox-host-modules-arch vlc youtube-dl htop tar p7zip xcompmgr audacity gimp cmus discord
pacman -S --noconfirm vifm make alsa-firmware wget xorg xorg-server xorg-xinit curl libxft fakeroot binutils vim patch pkgconf base-devel python-pywal pulseaudio alsa


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
pacman -S --noconfirm grub
# Install bootloader
grub-install /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

#makepkg in root
rm /usr/bin/makepkg
wget https://raw.githubusercontent.com/tajo48/ARCH-files/master/makepkg -O /usr/bin/makepkg
chmod +x /usr/bin/makepkg

###DWM part
#wallpaper
cd /home/tajo48
su tajo48 << 'NO'
wal -i /home/tajo48/ARCH-files/photos
NO



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
wget https://dwm.suckless.org/patches/single_tagset/dwm-single_tagset-20160731-56a31dc.diff


#patch (temporary)
cp dwm.c dwm.c.orig
patch < dwm-single_tagset-20160731-56a31dc.diff
read -p "enter"
patch < dwm-scratchpad-6.2.diff
read -p "enter"
patch < dwm-fakefullscreen-20170508-ceac8c9.diff
read -p "enter"
patch < dwm-pertag-6.2.diff
read -p "enter"
patch < dwm-uselessgap-6.2.diff
read -p "enter"
patch < dwm-movestack-6.1.diff
read -p "enter"
patch < dwm-centeredmaster-6.1.diff
read -p "enter"


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
wget https://st.suckless.org/patches/scrollback/st-scrollback-20200419-72e3f6c.diff
wget https://st.suckless.org/patches/clipboard/st-clipboard-0.8.3.diff

#patch
patch < st-scrollback-20200419-72e3f6c.diff
patch < st-alpha-0.8.2.diff
patch < st-clipboard-0.8.3.diff














#dwm try
cd /home/tajo48
echo "

wal -i /home/tajo48/ARCH-files/photos
setxkbmap -layout 'pl'
cd /home/tajo48/ARCH-builds/st
sudo make clean install
cd /home/tajo48/ARCH-builds/dmenu
sudo make clean install
cd /home/tajo48/ARCH-builds/dwm
sudo make clean install
#exec xcompmgr -c &
sudo sh /home/tajo48/ARCH-files/bar.sh &
cd /home/tajo48
exec dwm
" >> /home/tajo48/.xinitrc
pacman -S --noconfirm feh firefox rxvt-unicode
git clone https://github.com/tajo48/ARCH-builds.git


###MKPKG


<<com123
#Lightdm
pacman -S --noconfirm lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
systemctl enable lightdm -f

su tajo48 << 'NOI'
lightdm
NOI

#conky
#pywal

com123
