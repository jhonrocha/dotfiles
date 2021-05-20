#!/bin/bash -v

##### INSTALL PKGS
sudo pacman --noconfirm --needed -S \
    dunst feh flameshot slock \
    xorg xorg-xinit xorg-xmessage \
    xterm xclip xdo i3 picom

#### STOW THE PACKAGES
cd ~/dotfiles
stow dunst
stow picom
stow x
stow i3

#### Wallpaper
mkdir -p $HOME/.config/wallpapers
wget https://i.redd.it/qvvh6cxtvey61.png --output-document=$HOME/.config/wallpapers/landscape.png
