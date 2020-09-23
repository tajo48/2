#! /bin/bash

#programs
pacman -S --noconfirm alsa-utils netctl mtools dialog wpa_supplicant dhcpcd git neofetch mc xclip clipmenu rtorrent cura nano openssh notepadqq tmux arandr slock
pacman -S --noconfirm obs-studio blender bashtop calc virtualbox virtualbox-host-modules-arch vlc youtube-dl htop tar p7zip xcompmgr audacity gimp cmus discord nautilus
pacman -S --noconfirm vifm make alsa-firmware wget xorg xorg-server xorg-xinit curl libxft fakeroot binutils gvim neovim patch pkgconf base-devel python-pywal pulseaudio alsa
pacman -S --noconfirm firefox zsh

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

sed -i '/Port/s/^#//g' /etc/ssh/sshd_config
sed -i '/Port/ s/22/2137/' /etc/ssh/sshd_config
systemctl enable sshd



# Install bootloader
pacman -S --noconfirm grub
# Install bootloader
grub-install --target=i386-pc /dev/sda
grub-mkconfig -o /boot/grub/grub.cfg

#makepkg in root
rm /usr/bin/makepkg
curl -k -o /usr/bin/makepkg https://raw.githubusercontent.com/tajo48/ARCH-files/master/makepkg
chmod +x /usr/bin/makepkg

###DWM part
#wallpaper
cd /home/tajo48
git clone https://github.com/tajo48/ARCH-files.git
git clone https://github.com/tajo48/ARCH-builds.git
su tajo48 << 'NO'
wal -i /home/tajo48/ARCH-files/photos
curl -k -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    
sh -c 'curl -k -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
       
sh -c "$(curl -k -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
NO

#dwm try
cd /home/tajo48
echo -e "clipmenud &\nwal -i /home/tajo48/ARCH-files/photos\nsetxkbmap -layout 'pl'\nsetxkbmap -option 'caps:swapescape'\nxset r rate 300 50\ncd /home/tajo48/ARCH-builds/st\nsudo make clean install\ncd /home/tajo48/ARCH-builds/dmenu\nsudo make clean install\ncd /home/tajo48/ARCH-builds/dwm\nsudo make clean install\n#exec xcompmgr -c &\nsudo sh /home/tajo48/ARCH-files/bar.sh &\ncd /home/tajo48\nexec dwm\nclipmenud" >> /home/tajo48/.xinitrc
mkdir /home/tajo48/.config/nvim
cp /home/tajo48/ARCH-files/init.vim /home/tajo48/.config/nvim/init.vim
cp /home/tajo48/ARCH-files/zshrc /home/tajo48/.zshrc
chsh -s /bin/zsh tajo48
###MKPKG

#yay 
cd /home/tajo48/ARCH-builds/
git clone https://aur.archlinux.org/yay-git.git
cd /home/tajo48/ARCH-builds/yay-git
makepkg -s -i -c --noconfirm


chmod a=rwx /home/*
#git config --global credential.helper store
#xcape
#sudo chsh -s /bin/zsh tajo48
#(pacman zsh)
