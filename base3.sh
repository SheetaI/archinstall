sudo pacman -S --noconfirm sed
sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf

# Install Essentials #
sudo pacman -S --noconfirm xorg xorg-xinit  lightdm lightdm-gtk-greeter lightdm-gtk-greeter-settings \
 networkmanager git bspwm sxhkd rofi feh lxsession lxappearance thunar ranger picom \
 firefox mpd mpc ncmpcpp udisks2 udiskie thunar-archive-plugin file-roller dunst \
 gedit htop libreoffice bleachbit maim pulseaudio pulseaudio-alsa alsa alsa-utils \
 powerline powerline-fonts youtube-dl galculator ueberzug sxiv gnome-disk-utility \
 qbittorrent gimp veracrypt obsidian neofetch firewalld

# Start Network Service #
sudo systemctl enable NetworkManager	
sudo systemctl firewalld

# AUR Helper #
printf '\033c'
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
yay -S polybar ani-cli timeshift cava ttf-unifont ttf-symbola otf-symbola libxft-bgra-git brave-bin binance

# Font Rendering #
sudo cat <<EOF > /etc/fonts/local.conf
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
EOF

sudo ln -s /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/

cd $HOME
mkdir -p Pictures/Screenshots
mkdir -p .config/{bspwm,sxhkd}
install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc .config/bspwm/
install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc .config/sxhkd/
sed -i "s/^urxvt$/st/" $HOME/.config/sxhkd/sxhkdrc
cp /etc/X11/xinit/xinitrc $HOME/.xinitrc
echo "exec bspwm" >> $HOME/.xinitrc
chmod +x $HOME/.xinitrc
sudo groupadd -r autologin
sudo gpasswd -a sheetal autologin

# Enable services #
sudo systemctl lightdm

## End ##
exit
