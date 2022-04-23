#!/bin/bash

echo "-------------------------------------------------"
echo "     Configuring: Timezone | Locale | Host | Hostname"
echo "-------------------------------------------------"
sleep 3
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

echo "-------------------------------------------------"
echo "     Installating Addition Pkgs"
echo "-------------------------------------------------"
sleep 3
addpkgs="networkmanager git go reflector bash-completion"

while ! pacman -Syuw --noconfirm ${addpkgs}; do
  sleep 10
done
pacman -Su --noconfirm ${addpkgs}
clear

echo "-------------------------------------------------"
echo "     Setting systemd Bootloader"
echo "-------------------------------------------------"
sleep 3
bootctl --path=/boot install

cat <<EOF > /boot/loader/loader.conf
timeout 0
default arch-*
EOF

UUID="$(lsblk -dno UUID /dev/sda3)"
cat <<EOF > /boot/loader/entries/arch.conf
title    Arch Linux
linux    /vmlinuz-linux
initrd   /intel-ucode.img
initrd   /initramfs-linux.img
options root=UUID=$UUID rw
EOF

echo "-------------------------------------------------"
echo "     Enabling Internet Connection"
echo "-------------------------------------------------"
systemctl enable NetworkManager	

echo "-------------------------------------------------"
echo "    Setting User Account"
echo "-------------------------------------------------"
# User & Password Setup #
read -p "Enter username: " user
useradd -m $user
usermod -aG wheel $user
sed -i '/%wheel/s/^#//' /etc/sudoers
read -p "Enter password: " pass
echo -e "$pass\n$pass" | passwd $user
passwd -l root
sleep 3

## End ##
echo "-------------------------------------------------------------------"
echo "Base System Installation Finished...Reboot Now"
echo "-------------------------------------------------------------------"
exit
