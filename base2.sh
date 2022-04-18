#!/bin/bash

ln -sf /usr/share/zoneinfo/Asia/Manila /etc/localtime
hwclock --systohc											
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen													
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "arch" >> /etc/hostname

cat <<EOF > /etc/hosts
127.0.0.1 localhost
::1 localhost
127.0.1.1 arch.localdomain  arch
EOF

passwd

pacman -S --noconfirm networkmanager git terminus-font neofetch

bootctl --path=/boot install

cat <<EOF > /boot/loader/loader.conf
timeout 0
default arch-*
EOF

# For Physical Machine #
# cat <<EOF > /boot/loader/entries/arch.conf
# title    Arch Linux
# linux    /vmlinuz-linux
# initrd   /intel-ucode.img
# initrd   /initramfs-linux.img
# options  root=/dev/sda3 rw
# EOF

# For Virtual Machine #
cat <<EOF > /boot/loader/entries/arch.conf
title    Arch Linux
linux    /vmlinuz-linux
initrd   /intel-ucode.img
initrd   /initramfs-linux.img
options  root=/dev/vda3 rw
EOF

## === Start Services on Boot === ##
systemctl enable NetworkManager	

# user & pass

read -p "Enter username: " user
useradd -m $user
usermod -aG wheel $user
sed -i '/%wheel/s/^#//' /etc/sudoers
read -p "Enter password: " pass
echo -e "$pass\n$pass" | passwd $user
# lock root account
passwd -l root

## end ##
exit
