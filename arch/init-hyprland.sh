#!/bin/bash -v

##### INSTALL PKGS
sudo pacman --noconfirm --needed -S \
    hyprland hyprpolkitagent hyprpaper \
    xdg-desktop-portal-hyprland \
    mako polkit-gnome gnome-keyring \
    gtk3 gtk4 qt5-wayland qt6-wayland \
    seahorse xorg-xwayland \
    xdg-desktop-portal xdg-desktop-portal-gtk \
    wofi wl-clipboard hyprlock hyprpicker \
    waybar  swww  ghostty  nemo

# HYPRLAND RELATED
paru -S --needed hyprshot vicinae-bin

# Basic
sudo pacman --noconfirm --needed -S \
  nvim tmux stow zsh ripgrep fzf eza \
  ttf-iosevka-nerd ttf-jetbrains-mono-nerd noto-fonts-emoji 


# Fancy
sudo pacman --noconfirm --needed -S \
  lazygit
