#!/bin/bash

# == PERSONALIZATION PART 1 == #

# == Contents: my choice of pkgs == #

# Configurations #
sudo sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
sudo reflector --verbose --country Singapore,Taiwan,Indonesia,Thailand --latest 20 --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo bash -c "echo -e '\n[multilib]\nInclude = /etc/pacman.d/mirrorlist' >>/etc/pacman.conf"
sudo pacman -Syyu

# Pkgs #
pkgs="$("xorg" "xorg-xinit" "lightdm" "lightdm-gtk-greeter" "lightdm-gtk-greeter-settings" "neofetch" "firewalld" "bspwm" "sxhkd" "rofi" "feh" "lxsession" "lxappearance" "thunar" "ranger" "picom"
"firefox" "mpd" "mpc" "ncmpcpp" "udisks2" "udiskie" "thunar-archive-plugin" "file-roller" "dunst" "gedit" "htop" "libreoffice" "bleachbit" "maim" "pulseaudio" "pulseaudio-alsa" "alsa" "alsa-utils"
"powerline" "powerline-fonts" "youtube-dl" "galculator" "ueberzug" "sxiv" "gnome-disk-utility" "qbittorrent" "gimp" "veracrypt" "obsidian" "bash-completion")"

# Install Needed Pkgs #
while ! pacman -Syw $pkgs; do
  sleep 10
done
pacman -Su ${pkgs}

#sudo pacman -S --noconfirm xorg xorg-xinit  lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings \
# neofetch firewalld bspwm sxhkd rofi feh lxsession lxappearance thunar ranger picom \
# firefox mpd mpc ncmpcpp udisks2 udiskie thunar-archive-plugin file-roller dunst \
# gedit htop libreoffice bleachbit maim pulseaudio pulseaudio-alsa alsa alsa-utils \
# powerline powerline-fonts youtube-dl galculator ueberzug sxiv gnome-disk-utility \
# qbittorrent gimp veracrypt obsidian bash-completion

# St terminal #
cd $HOME
git clone https://github.com/siduck/st.git && cd st
sudo make install

cd $HOME/archinstall
chmod +x personal2.sh
./personal2.sh

# continuation on personal2.sh #

