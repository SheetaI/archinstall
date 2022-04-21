#!/bin/bash

# == ARCH LINUX BASE SYSTEM INSTALLATION == #
# == PART 2 == #

# Timezone | Locale | Host | Hostname #
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

# Additional pkgs #
pacman -S --noconfirm networkmanager git

# Systemd Bootlader Setup #
bootctl --path=/boot install

cat <<EOF > /boot/loader/loader.conf
timeout 0
default arch-*
EOF

# For Physical Machine #
UUID="$(lsblk -dno UUID /dev/sda3)"
cat <<EOF > /boot/loader/entries/arch.conf
title    Arch Linux
linux    /vmlinuz-linux
initrd   /intel-ucode.img
initrd   /initramfs-linux.img
options root=UUID=$UUID rw
EOF

# For Virtual Machine #
# UUID="$(lsblk -dno UUID /dev/vda3)"
# cat <<EOF > /boot/loader/entries/arch.conf
# title    Arch Linux
# linux    /vmlinuz-linux
# initrd   /intel-ucode.img
# initrd   /initramfs-linux.img
# options root=UUID=$UUID rw
# EOF

# Startup Service #
systemctl enable NetworkManager	

# User & Password Setup #
read -p "Enter username: " user
useradd -m $user
usermod -aG wheel $user
sed -i '/%wheel/s/^#//' /etc/sudoers
read -p "Enter password: " pass
echo -e "$pass\n$pass" | passwd $user
passwd -l root

## End ##
echo "-------------------------------------------------------------------"
echo "Base System Installation Completed...Reboot Now"
echo "-------------------------------------------------------------------"
exit
