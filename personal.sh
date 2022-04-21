#!/bin/bash

#-------------------------------------------------------------------------
#  Arch Linux Post Install: Part #1 Pacman Pkgs
#-------------------------------------------------------------------------

# Configurations #
sudo sed -i "s/^#ParallelDownloads = 5$/ParallelDownloads = 15/" /etc/pacman.conf
sudo reflector --verbose --country Singapore,Taiwan,Indonesia,Thailand --latest 20 --age 12 --protocol https --sort rate --save /etc/pacman.d/mirrorlist
sudo bash -c "echo -e '\n[multilib]\nInclude = /etc/pacman.d/mirrorlist' >>/etc/pacman.conf"
sudo pacman -Syyu

# Pkgs installation #

    PKGS=(

        # --- XORG Display Rendering
            'xorg'                
            'xorg-xinit'           

        # --- Login Display Manager
            'lightdm'                 
	    'lightdm-gtk-greeter'
	    'lightdm-gtk-greeter-settings'

        # --- Desktop Environment -- #
	    'bspwm'
	    'sxhkd'
	    'feh'
	    'sxiv'
	    'ueberzug'
	    'maim'
            'rofi'                  
            'picom'      
            'dunst '          
            'lxsession'
            'lxappearance'          
	    'thunar'
	    'ranger'
	    'galculator'
	    'gnome-disk-utility'
	    'udisks2'
	    'udiskie'
	    'thunar-archive-plugin'
	    'file-roller'
	    'gedit'
	    'htop'
	    'neofetch'
	    'bash-completion'
	    'powerline'
	    'powerline-fonts'
	    'libreoffice'
	    'bleachbit'
	    'veracrypt'
	    'obsidian'
	    'firefox'
	    
        # --- Media -- #	  
	    'mpd'
	    'mpc'
	    'ncmpcpp'
	    'qbittorrent'
	    'gimp'
	    'pulseaudio'
	    'pulseaudio-alsa'
	    'alsa'
	    'alsa-utils'
	    'youtube-dl'	    
    )

while ! pacman -Syw ${pkgs}; do
  sleep 10
done
pacman -Su ${pkgs}

cd $HOME/archinstall
chmod +x personal2.sh
./personal2.sh

# continuation on personal2.sh #


