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

cd $HOME
mkdir -p Pictures/Screenshots

sudo groupadd -r autologin
sudo gpasswd -a sheetal autologin

cat <<EOF > .bashrc
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

echo "alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'" >> .bash_aliases
bash
echo "dotfiles" >> .gitignore
git clone --bare https://github.com/SheetaI/dotfiles $HOME/dotfiles
alias config='/usr/bin/git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
config checkout



# Enable services #
sudo systemctl enable lightdm

## End ##
exit
