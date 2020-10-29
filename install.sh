#! /bin/bash
selectdisk(){
		items=$(lsblk -d -p -n -l -o NAME,SIZE -e 7,11)
		options=()
		IFS_ORIG=$IFS
		IFS=$'\n'
		for item in ${items}
		do  
				options+=("${item}" "")
		done
		IFS=$IFS_ORIG
		result=$(whiptail --backtitle "${APPTITLE}" --title "${1}" --menu "" 0 0 0 "${options[@]}" 3>&1 1>&2 2>&3)
		if [ "$?" != "0" ]
		then
				return 1
		fi
		return 0    
}

selectdisk
disk=${result%%\ *}



# Font
loadkeys pl
setfont Lat2-Terminus16.psfu.gz -m 8859-2


if [ "$1" == "pen" ];
then
parted ${disk} --script mklabel msdos
parted ${disk} --script mkpart primary fat32 1MiB 300MiB #boot /dev/sda1
parted ${disk} --script mkpart primary linux-swap 300MiB 820MiB #boot /dev/sda1
parted ${disk} --script mkpart primary ext4 820MiB 100% #boot /dev/sda1


wipefs ${disk}1
wipefs ${disk}2
wipefs ${disk}3

mkfs.fat -F32 ${disk}1
mkswap ${disk}2
mkfs.ext4 ${disk}3

mount ${disk}3 /mnt
swapon ${disk}2
mkdir /mnt/efi
mkdir /mnt/boot


else
parted ${disk} --script mklabel msdos
parted ${disk} --script mkpart primary linux-swap 1MiB 300MiB #boot /dev/sda1
parted ${disk} --script mkpart primary ext4 300MiB 100% #root /dev/sda2
parted ${disk} --script set 2 boot on

# Wipefs
wipefs ${disk}1
wipefs ${disk}2

# Mkfs
mkfs.ext4 ${disk}2
mkswap ${disk}1

# Mount the partitions
mount ${disk}2 /mnt
mkdir /mnt/boot
swapon ${disk}1
fi


# Setup the disk and partitions
# Set up time
timedatectl set-ntp true

# Initate pacman keyring
<<com
pacman-key --init
pacman-key --populate archlinux
pacman-key --refresh-keys
com


# Install Arch Linux
pacstrap /mnt base linux pacman sudo linux-firmware dosfstools wget

# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Copy post-install system cinfiguration script to new /root
    curl -k --create-dirs -o /mnt/root/after.sh https://raw.githubusercontent.com/tajo48/ARCH-linux-install-script/bios/after.sh
    chmod +x /mnt/root/after.sh

# Chroot into new system
arch-chroot /mnt /root/after.sh ${disk} ${1}

 
