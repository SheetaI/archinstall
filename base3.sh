# Font Rendering #
cat <<EOF | sudo tee -a > /etc/fonts/local.conf
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
sudo systemctl enable lightdm

## End ##
exit
