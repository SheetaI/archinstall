#!/bin/bash

# == PERSONALIZATION PART 1 == #

# == Contents: All about AUR == #

sudo pacman -Syu
sudo pacman -S --noconfirm sed
sudo sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
sudo bash -c "echo -e '\n[multilib]\nInclude = /etc/pacman.d/mirrorlist' >>/etc/pacman.conf"
sudo pacman -Syu
sudo pacman -S --noconfirm go

# AUR Helper #
cd $HOME
git clone https://aur.archlinux.org/yay.git && cd yay
yes | makepkg -si

# AUR Pkgs #
cd $HOME
echo && yay -S --noconfirm --removemake --cleanafter polybar ani-cli-git timeshift cava ttf-unifont ttf-symbola otf-symbola libxft-bgra-git brave-bin binance

cd $HOME/archinstall
chmod +x personal2.sh
./personal2.sh

# continuation on personal2.sh #
