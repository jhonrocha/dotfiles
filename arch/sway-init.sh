#!/bin/bash -v

##### INSTALL PKGS
sudo pacman --noconfirm --needed -S \
    sway grim wl-clipboard slurp \
    mako polkit-gnome \
    gtk3 gtk4 \
    qt5-wayland qt6-wayland
