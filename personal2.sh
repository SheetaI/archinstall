#!/bin/bash

# == PERSONALIZATION PART 2 == #

# == Contents: my choice of pkgs & dotfiles == #

# Install Needed Pkgs #
sudo pacman -S --noconfirm xorg xorg-xinit  lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings \
 neofetch firewalld bspwm sxhkd rofi feh lxsession lxappearance thunar ranger picom \
 firefox mpd mpc ncmpcpp udisks2 udiskie thunar-archive-plugin file-roller dunst \
 gedit htop libreoffice bleachbit maim pulseaudio pulseaudio-alsa alsa alsa-utils \
 powerline powerline-fonts youtube-dl galculator ueberzug sxiv gnome-disk-utility \
 qbittorrent gimp veracrypt obsidian bash-completion

# Font Rendering #
sudo bash -c 'cat <<EOF > /etc/fonts/local.conf
<?xml version="1.0"?>
<!DOCTYPE fontconfig SYSTEM "fonts.dtd">
<fontconfig>
  <match target="font">
    <edit name="antialias" mode="assign">
      <bool>true</bool>
    </edit>
    <edit name="hinting" mode="assign">
      <bool>true</bool>
    </edit>
    <edit mode="assign" name="rgba">
      <const>rgb</const>
    </edit>
    <edit mode="assign" name="hintstyle">
      <const>hintslight</const>
    </edit>
    <edit mode="assign" name="lcdfilter">
      <const>lcddefault</const>
    </edit>
  </match>
</fontconfig>
EOF'
sudo ln -s /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/

# Enable services #
cd $HOME
sudo systemctl enable lightdm
sudo systemctl enable firewalld

# Autologin #
sudo groupadd -r autologin
sudo gpasswd -a sheetal autologin
sudo sed -i "s/^#autologin-user=$/autologin-user=sheetal/" /etc/lightdm/lightdm.conf
sudo sed -i "s/^#autologin-user-timeout=0$/autologin-user-timeout=0/" /etc/lightdm/lightdm.conf

# Ricing #
cd $HOME
mkdir -p {Music,Videos}
mkdir -p Pictures/Screenshots

# Dotfiles Bare Repo #
cd $HOME
echo "alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'" >> .bash_aliases
echo "dotfiles" >> .gitignore
git clone --bare https://github.com/SheetaI/dotfiles.git $HOME/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'

# remove duplicates before checkout
rm .bash_aliases
rm .bashrc
rm -rf .config/*
rm -rf .config

# config checkout
/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME checkout
# config config --local status.showUntrackedFiles no
/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no

# Make executables #
cd $HOME/.ncmpcpp/ncmpcpp-ueberzug
chmod +x ncmpcpp_cover_art.sh
chmod +x ncmpcpp-ueberzug

# End #
echo "-------------------------------------------------------------------"
echo "Finished Installing Everything...Reboot & Enjoy !!!"
echo "-------------------------------------------------------------------"
