#!/bin/bash -v

##### INSTALL PKGS
sudo pacman --noconfirm --needed -S \
    dunst feh flameshot slock acpilight
    xorg xorg-xinit xorg-xmessage \
    xterm xclip xdo i3 picom

#### STOW THE PACKAGES
cd /data/dotfiles > /dev/null 2>&1 || cd ~/dotfiles
stow dunst -t ~/
stow picom -t ~/
stow x -t ~/
stow i3 -t ~/
stow i3status -t ~/

#### Wallpaper
mkdir -p $HOME/.config/wallpapers
wget https://i.redd.it/e7wkv05iujg61.png --output-document=$HOME/.config/wallpapers/landscape.png
