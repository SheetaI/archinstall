#!/bin/bash

echo "-------------------------------------------------"
echo "    SHEETAL'S SYSTEM PERSONALIZATION"
echo "-------------------------------------------------"

echo "-------------------------------------------------"
echo "     Prepairing"
echo "-------------------------------------------------"
sudo sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
sudo reflector --verbose --country Singapore,Taiwan,Indonesia,Thailand --latest 20 --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo bash -c "echo -e '\n[multilib]\nInclude = /etc/pacman.d/mirrorlist' >>/etc/pacman.conf"
pacman -Sy --noconfirm archlinux-keyring
sudo pacman -Syyu

echo "-------------------------------------------------"
echo "     Installing Pacman Pkgs"
echo "-------------------------------------------------"
pkg_list="xorg xorg-xinit lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings neofetch firewalld bspwm sxhkd rofi feh lxsession lxappearance thunar ranger picom firefox mpd mpc ncmpcpp udisks2 udiskie thunar-archive-plugin file-roller dunst gedit libreoffice galculator htop maim pulseaudio pulseaudio-alsa alsa alsa-utils powerline powerline-fonts youtube-dl ueberzug sxiv qbittorrent gimp veracrypt obsidian bleachbit gnome-disk-utility"

while ! sudo pacman -Syuw --noconfirm ${pkg_list}; do
  sleep 10
done
sudo pacman -Su --noconfirm ${pkg_list}
sleep 5
clear

echo "-------------------------------------------------"
echo "     Installing AUR Helper"
echo "-------------------------------------------------"
cd ${HOME}
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si --noconfirm --needed
sleep 5
clear

echo "-------------------------------------------------"
echo "     Installing AUR Pkgs"
echo "-------------------------------------------------"
aurpkgs="polybar timeshift cava ttf-unifont ttf-symbola otf-symbola ani-cli-git libxft-bgra-git brave-bin binance"

while ! (echo "1"; echo "1"; echo "1"; echo "1"; echo "y"; echo "\n"; echo "Y"; echo "Y"; yes "Y") | yay -Sy ${aurpkgs}; do
  sleep 10
done
(echo "\n"; echo "\n") | yay -Su --cleanafter ${aurpkgs}
sleep 5
clear

#OLD WORKING BUT NEEDS CONFIRMATIONS"
#yay -S polybar timeshift cava ttf-unifont ttf-symbola otf-symbola ani-cli-git libxft-bgra-git brave-bin binance
#sleep 5	
#clear

echo "-------------------------------------------------"
echo "     Installing St Terminal"
echo "-------------------------------------------------"
cd ${HOME}
git clone "https://github.com/siduck/st.git"
cd ${HOME}/st
sudo make install
sleep 5	
clear

echo "-------------------------------------------------"
echo "     Setting up Dotfiles"
echo "-------------------------------------------------"
sleep 5
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

echo "-------------------------------------------------"
echo "     Setting up executables"
echo "-------------------------------------------------"
# Make executables #
cd $HOME/.ncmpcpp/ncmpcpp-ueberzug
chmod +x ncmpcpp_cover_art.sh
chmod +x ncmpcpp-ueberzug

echo "-------------------------------------------------"
echo "    Miscellaneous"
echo "-------------------------------------------------"
cd $HOME
# Additional Directories #
mkdir -p {Music,Videos}
mkdir -p Pictures/Screenshots

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
clear

echo "-------------------------------------------------"
echo "     Enabling Startup Services"
echo "-------------------------------------------------"
cd $HOME
sudo systemctl enable lightdm
sudo systemctl enable firewalld

echo "-------------------------------------------------"
echo "     Enabling User Autologin"
echo "-------------------------------------------------"
sudo groupadd -r autologin
sudo gpasswd -a sheetal autologin
sudo sed -i "s/^#autologin-user=$/autologin-user=sheetal/" /etc/lightdm/lightdm.conf
sudo sed -i "s/^#autologin-user-timeout=0$/autologin-user-timeout=0/" /etc/lightdm/lightdm.conf

echo "-------------------------------------------------------------------"
echo "Finished Installing Everything...Reboot & Enjoy !!!"
echo "-------------------------------------------------------------------"
exit
