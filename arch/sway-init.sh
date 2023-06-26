#!/bin/bash -v

##### INSTALL PKGS
sudo pacman --noconfirm --needed -S \
    sway grim wl-clipboard slurp \
    swappy mako polkit-gnome \
    gtk3 gtk4 xdg-desktop-portal-wlr \
    qt5-wayland qt6-wayland
