#!/bin/bash -v

##### INSTALL PKGS
sudo pacman --noconfirm --needed -S \
    sway swaybg grim wl-clipboard slurp \
    swappy mako polkit-gnome \
    gtk3 gtk4 qt5-wayland qt6-wayland \
    seahorse \
    xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk
