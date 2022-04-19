# == POST-BASE INSTALL PERSONALIZATION == #
# curl -JLO https://raw.githubusercontent.com/SheetaI/archinstall/master/base3.sh

sudo pacman -Syu

# Install Needed Packages #
sudo pacman -S --noconfirm xorg xorg-xinit  lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings \
 neofetch firewalld bspwm sxhkd rofi feh lxsession lxappearance thunar ranger picom \
 firefox mpd mpc ncmpcpp udisks2 udiskie thunar-archive-plugin file-roller dunst \
 gedit maim pulseaudio pulseaudio-alsa alsa alsa-utils \
 powerline powerline-fonts youtube-dl galculator ueberzug sxiv \
 bash-completion sed go

# AUR Helper #
cd $HOME
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si

# St terminal #
cd $HOME
git clone https://github.com/siduck/st.git
cd st
sudo make install

# AUR Packages #
cd $HOME
yay -S --noconfirm --removemake --cleanafter polybar ani-cli-git cava ttf-unifont ttf-symbola otf-symbola libxft-bgra-git 

# Font Rendering #
cd $HOME
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

# Autologin #
sudo groupadd -r autologin
sudo gpasswd -a sheetal autologin
sed -i "s/^#autologin-user=$/autologin-user=sheetal/" /etc/lightdm/lightdm.conf
sed -i "s/^#autologin-user-timeout=0$/autologin-user-timeout=0/" /etc/lightdm/lightdm.conf

# Ricing #
cd $HOME
mkdir Music
mkdir -p Pictures/Screenshots

# Dotfiles #
sudo bash -c 'cat <<EOF > .bashrc
# alias sourcing
if [ -f ~/.bash_aliases ]; then
	.  ~/.bash_aliases
fi

neofetch
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/share/powerline/bindings/bash/powerline.sh
EOF'

cd $HOME
echo "alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'" >> .bash_aliases
echo "dotfiles" >> .gitignore
git clone --bare https://github.com/SheetaI/dotfiles.git $HOME/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
# config checkout
/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME checkout
# config config --local status.showUntrackedFiles no
/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no

cd $HOME/.ncmpcpp/ncmpcpp-ueberzug
chmod +x ncmpcpp_cover_art.sh
chmod +x ncmpcpp-ueberzug

# Enable services #
cd $HOME
sudo systemctl enable lightdm
sudo systemctl enable firewalld

## End ##
exit
echo "reboot and enjoy"
