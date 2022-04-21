#!/bin/bash

#-------------------------------------------------------------------------
#  Arch Linux Post Install: Part #2 AUR & Dotfiles
#-------------------------------------------------------------------------

sudo pacman -Syu
echo "-------------------------------------------------"
echo "     Installing AUR Helper"
echo "-------------------------------------------------"
cd ${HOME}
git clone "https://aur.archlinux.org/yay.git"
cd ${HOME}/yay
makepkg -si --noconfirm --needed
clear
    
# AUR Pkgs #
aurpkgs=(
    
	'polybar'
	'ani-cli-git'
	'timeshift'
	'cava'
	'ttf-unifont'
	'ttf-symbola'
	'otf-symbola'
	'libxft-bgra-git'
	'brave-bin'
	'binance'    
    )
    
echo "-------------------------------------------------"
echo "     Installing AUR Pkgs"
echo "-------------------------------------------------"
while ! yay -S ${aurpkgs} --noconfirm --needed; do
  sleep 10
done
yay -Su ${aurpkgs} --noconfirm --needed

echo "-------------------------------------------------"
echo "     Installing St Terminal"
echo "-------------------------------------------------"
cd ${HOME}
git clone "https://github.com/siduck/st.git"
cd ${HOME}/st
sudo make install --noconfirm --needed
clear


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
exit
