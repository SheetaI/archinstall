# == MY ARCH SETUP INSTALLER == #

# Configurations #
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
loadkeys us
timedatectl set-ntp true

# Partitions: 100MB=BOOT, 4GB=SWAP, remaining=ROOT #
echo -e "o\ny\nn\n \n \n+100M\nef00\nn\n \n \n+4G\n8200\nn\n \n \n \n8300\nw\ny" | gdisk /dev/vda

# Format: Physical Machine #
# mkfs.fat -F32 /dev/sda1		
# mkswap /dev/sda2			
# swapon /dev/sda2			
# mkfs.ext4 /dev/sda3

# Mount: Physical Machine #
# mount /dev/sda3 /mnt
# mkdir /mnt/boot
# mount /dev/sda1 /mnt/boot

# Format: Virtual Machine #
mkfs.fat -F32 /dev/vda1		
mkswap /dev/vda2			
swapon /dev/vda2			
mkfs.ext4 /dev/vda3

# Mount: Virtual Machine #
mount /dev/vda3 /mnt
mkdir /mnt/boot
mount /dev/vda1 /mnt/boot

# Installation #
pacstrap /mnt base base-devel linux linux-firmware vim intel-ucode
genfstab -U /mnt >> /mnt/etc/fstab

cp base2.sh /mnt
chmod +x /mnt/base2.sh

arch-chroot /mnt /bin/bash -c ./base2.sh

# continuation on base2.sh #
