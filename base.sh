# == MY ARCH SETUP INSTALLER == #

sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
loadkeys us
timedatectl set-ntp true

echo -e "o\ny\nn\n \n \n+100M\nef00\nn\n \n \n+4G\n8200\nn\n \n \n \n8300\nw\ny" | gdisk /dev/vda

mkfs.fat -F32 /dev/sda1		
mkswap /dev/sda2			
swapon /dev/sda2			
mkfs.ext4 /dev/sda3

mount /dev/sda3 /mnt
mkdir /mnt/boot
mount /dev/sda1 /mnt/boot

pacstrap /mnt base base-devel linux linux-firmware vim intel-ucode
genfstab -U /mnt >> /mnt/etc/fstab

cp base2.sh /mnt
chmod +x /mnt/base2.sh

arch-chroot /mnt /bin/bash -c ./base2.sh


