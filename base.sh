#!/bin/bash

echo "-------------------------------------------------"
echo "    SHEETAL'S BASE SYSTEM INSTALLATION"
echo "-------------------------------------------------"

echo "-------------------------------------------------"
echo "     Prepairing"
echo "-------------------------------------------------"
sleep 3
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
pacman -Sy --noconfirm archlinux-keyring
pacman-key --refresh-keys
loadkeys us
timedatectl set-ntp true

echo "-------------------------------------------------"
echo "     Partitioning Drive"
echo "-------------------------------------------------"
echo " 100MB=BOOT | 4GB=SWAP | Remaing=ROOT"
echo "-------------------------------------------------"
sleep 3
yes | echo -e "o\ny\nn\n \n \n+100M\nef00\nn\n \n \n+4G\n8200\nn\n \n \n \n8300\nw\ny" | gdisk /dev/sda
clear 

echo "-------------------------------------------------"
echo "     Formatting Drive"
echo "-------------------------------------------------"
echo " FAT32=BOOT | LINUX SWAP=SWAP | LINUX FILESYSTEM=ROOT"
echo "-------------------------------------------------"
sleep 3
mkfs.fat -F32 /dev/sda1		
mkswap /dev/sda2			
swapon /dev/sda2			
mkfs.ext4 /dev/sda3

echo "-------------------------------------------------"
echo "     Mounting Drive"
echo "-------------------------------------------------"
echo " /mnt/boot=BOOT | /=ROOT"
echo "-------------------------------------------------"
sleep 3
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot
clear

echo "-------------------------------------------------"
echo "    Installing Base System"
echo "-------------------------------------------------"
sleep 3
basepkgs="base base-devel linux linux-firmware vim intel-ucode"

while ! pacstrap /mnt ${basepkgs}; do
  sleep 10
done
pacstrap -U /mnt ${basepkgs}
clear

echo "-------------------------------------------------"
echo "    Generating fstab"
echo "-------------------------------------------------"
sleep 3
genfstab -U /mnt >> /mnt/etc/fstab
cp base2.sh /mnt
cp sheetal.sh /mnt

echo "-------------------------------------------------"
echo "    Proceeding installation"
echo "-------------------------------------------------"
sleep 3
chmod +x /mnt/base2.sh
arch-chroot /mnt /bin/bash -c ./base2.sh

# continuation on base2.sh #
