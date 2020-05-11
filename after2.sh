
#wallpaper
mkdir /home/tajo48/photos
wget https://raw.githubusercontent.com/tajo48/2/master/wallpaper.jpg -O /home/tajo48/photos/wallpaper.jpg

#dwm try
cd /home/tajo48
echo "feh --bg-fill /home/tajo48/photos/wallpaper.jpg
setxkbmap -layout 'pl'
exec dwm" >> ~/.xinitrc
pacman -S --noconfirm feh firefox rxvt-unicode neofetch

#download (almost temporary)
git clone https://git.suckless.org/dwm/
git clone https://git.suckless.org/st/
git clone https://git.suckless.org/dmenu/
git clone https://git.suckless.org/surf/

#wgetpatch (temporary)
cd /home/tajo48/dwm
wget https://dwm.suckless.org/patches/fakefullscreen/dwm-fakefullscreen-20170508-ceac8c9.diff
wget https://dwm.suckless.org/patches/pertag/dwm-pertag-6.2.diff
wget https://dwm.suckless.org/patches/uselessgap/dwm-uselessgap-6.2.diff

#patch (temporary)
cd /home/tajo48/dwm
<<lol
cp dwm.c dwm.c.orig
patch < dwm-fakefullscreen-20170508-ceac8c9.diff
cp config.h config.def.h
patch < dwm-pertag-6.2.diff
patch < dwm-uselessgap-6.2.diff
mv config.def.h config.h
lol
cp dwm.c dwm.c.orig
cp config.h config.def.h
sleep 20s

<koniec
#makekpkg
cd /home/tajo48/st
make clean install
cd /home/tajo48/dmenu
make clean install
cd /home/tajo48/surf
make clean install
cd /home/tajo48/dwm
make clean install
#makepkg -sic --noconfirm --skipchecksums

startx