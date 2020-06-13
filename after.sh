#! /bin/bash

#programs
pacman -S --noconfirm alsa-utils netctl mtools dialog wpa_supplicant dhcpcd git make alsa-firmware wget xorg-server xorg-xinit curl libxft fakeroot binutils patch pkgconf base-devel  
#pacman -S --noconfirm neofetch obs-studio blender bashtop calc virtualbox virtualbox-host-modules-arch virtualbox-host-dkms vlc youtube-dl htop tar p7zip vim vifm xcompmgr
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
#cd /home/tajo48/suckless
#git clone https://aur.archlinux.org/yay-git.git
#cd /home/tajo48/suckless/yay-git
#makepkg -s -i -c --noconfirm

###DWM part
#wallpaper
mkdir /home/tajo48/photos
wget https://raw.githubusercontent.com/tajo48/ARCH-files/master/photos/wallpaper.jpg -O /home/tajo48/photos/wallpaper.jpg
#dwm try
cd /home/tajo48
echo "feh --bg-fill /home/tajo48/photos/wallpaper.jpg
setxkbmap -layout 'pl'
#exec xcompmgr -c &
exec dwm" >> /home/tajo48/.xinitrc
pacman -S --noconfirm feh firefox rxvt-unicode
mkdir /home/tajo48/photos
wget https://raw.githubusercontent.com/tajo48/ARCH-files/master/photos/wallpaper.jpg -O /home/tajo48/photos/wallpaper.jpg
git clone https://github.com/tajo48/ARCH-builds.git


###MKPKG
#cp config.h config.def.h
#makekpkg
cd /home/tajo48/ARCH-builds/st
make clean install
cd /home/tajo48/ARCH-builds/dmenu
make clean install
cd /home/tajo48/ARCH-builds/dwm
make clean install


<<com123
#Lightdm
pacman -S --noconfirm lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings
systemctl enable lightdm -f

su tajo48 << 'NO'
lightdm
NO

#conky
#pywal

com123
