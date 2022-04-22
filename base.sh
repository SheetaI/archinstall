#!/bin/bash

echo "-------------------------------------------------"
echo "    SHEETAL'S BASE SYSTEM INSTALLATION"
echo "-------------------------------------------------"

echo "-------------------------------------------------"
echo "     Prepairing"
echo "-------------------------------------------------"
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
pacman -Sy --noconfirm archlinux-keyring
loadkeys us
timedatectl set-ntp true


echo "-------------------------------------------------"
echo "     Partitioning Drive"
echo "-------------------------------------------------"
echo " 100MB=BOOT | 4GB=SWAP | Remaing=ROOT"
echo "-------------------------------------------------"

# Partition: For Physican Machine #
yes | echo -e "o\ny\nn\n \n \n+100M\nef00\nn\n \n \n+4G\n8200\nn\n \n \n \n8300\nw\ny" | gdisk /dev/sda
sleep 3
clear 

# Partition: For Virtual Machine #
#yes | echo -e "o\ny\nn\n \n \n+100M\nef00\nn\n \n \n+4G\n8200\nn\n \n \n \n8300\nw\ny" | gdisk /dev/vda
#sleep 3
#sclear 

echo "-------------------------------------------------"
echo "     Formatting Physical Drive"
echo "-------------------------------------------------"
echo " FAT32=BOOT | LINUX SWAP=SWAP | LINUX FILESYSTEM=ROOT"
echo "-------------------------------------------------"
mkfs.fat -F32 /dev/sda1		
mkswap /dev/sda2			
swapon /dev/sda2			
mkfs.ext4 /dev/sda3

echo "-------------------------------------------------"
echo "     Mounting Physical Drive"
echo "-------------------------------------------------"
echo " /mnt/boot=BOOT | /=ROOT"
echo "-------------------------------------------------"
mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot


#echo "-------------------------------------------------"
#echo "     Formatting Virtual Drive"
#echo "-------------------------------------------------"
#echo " FAT32=BOOT | LINUX SWAP=SWAP | LINUX FILESYSTEM=ROOT"
#echo "-------------------------------------------------"
#mkfs.fat -F32 /dev/vda1		
#mkswap /dev/vda2			
#swapon /dev/vda2			
#mkfs.ext4 /dev/vda3

#echo "-------------------------------------------------"
#echo "     Mounting Virtual Drive"
#echo "-------------------------------------------------"
#echo " /mnt/boot=BOOT | /=ROOT"
#echo "-------------------------------------------------"
#mount /dev/vda3 /mnt
#mkdir /mnt/boot
#mount /dev/vda1 /mnt/boot
sleep 3

echo "-------------------------------------------------"
echo "    Installing Base System"
echo "-------------------------------------------------"
basepkgs="base base-devel linux linux-firmware vim intel-ucode"

while ! pacstrap /mnt ${basepkgs}; do
  sleep 10
done
pacstrap -U /mnt ${basepkgs}
sleep 3
clear

echo "-------------------------------------------------"
echo "    Generating fstab"
echo "-------------------------------------------------"
genfstab -U /mnt >> /mnt/etc/fstab
cp base2.sh /mnt
cp sheetal.sh /mnt

echo "-------------------------------------------------"
echo "    Proceeding installation"
echo "-------------------------------------------------"
chmod +x /mnt/base2.sh
arch-chroot /mnt /bin/bash -c ./base2.sh

# continuation on base2.sh #
