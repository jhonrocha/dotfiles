#!/bin/bash -v

##### INSTALL PKGS
sudo pacman --noconfirm --needed -S \
    sway swaybg grim wl-clipboard slurp \
    swappy mako polkit-gnome gnome-keyring \
    gtk3 gtk4 qt5-wayland qt6-wayland \
    seahorse xorg-xwayland acpilight \
    xdg-desktop-portal xdg-desktop-portal-wlr xdg-desktop-portal-gtk
