#! /bin/bash

#programs
pacman -S --noconfirm alsa-utils netctl grub os-prober mtools dialog wpa_supplicant dhcpcd vim git make alsa-firmware wget xorg-server pulseaudio xorg-xinit curl tar libxft ranger fakeroot binutils patch pkgconf base-devel
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
pacman -S --noconfirm lightdm-gtk-greeter lightdm-gtk-greeter-settings lightdm-webkit2-greeter xmonad
echo "greeter-session=example-gtk-gnome" >> /etc/lightdm/lightdm.conf
systemctl enable lightdm -f

