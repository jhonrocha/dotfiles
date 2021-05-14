#!/bin/bash -v

##### INSTALL PKGS
sudo pacman --noconfirm --needed -S \
    dunst feh flameshot slock \
    xmonad xmonad-contrib xorg xorg-xinit \
    xorg-xmessage xterm xclip xdo \
    i3 picom

#### STOW THE PACKAGES
cd ~/dotfiles
stow dunst picom x i3
