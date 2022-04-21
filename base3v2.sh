#!/bin/bash

# == PERSONALIZATION == #
# curl -JLO https://raw.githubusercontent.com/SheetaI/archinstall/master/base3.sh

sudo pacman -Syu
sudo pacman -S --noconfirm sed
sudo sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
#sudo sed -i "s/^#[multilib]$/[multilib]/" /etc/pacman.conf

sudo pacman -S --noconfirm go

# AUR Helper #
cd $HOME
git clone https://aur.archlinux.org/yay.git && cd yay
yes | makepkg -si

# St terminal #
cd $HOME
git clone https://github.com/siduck/st.git
cd st
sudo make install

# AUR Pkgs #
cd $HOME
echo && yay -S --noconfirm --removemake --cleanafter polybar ani-cli-git timeshift cava ttf-unifont ttf-symbola otf-symbola libxft-bgra-git brave-bin binance

cd $HOME/archinstall
chmod +x base4.sh
./base4.sh
