#!/bin/bash -v

##### INSTALL PKGS
sudo pacman --noconfirm --needed -S \
    hyprland hyprpolkitagent hyprpaper \
    xdg-desktop-portal-hyprland \
    mako polkit-gnome gnome-keyring \
    gtk3 gtk4 qt5-wayland qt6-wayland \
    seahorse xorg-xwayland acpilight \
    xdg-desktop-portal xdg-desktop-portal-gtk \
    wofi wl-clipboard hyprlock hyprpicker

# paru hyprshot
