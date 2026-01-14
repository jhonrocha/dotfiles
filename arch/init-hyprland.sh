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
    waybar  swww  ghostty swappy \
    pipewire wireplumber \
    nemo nemo-fileroller nemo-compare nemo-terminal


# HYPRLAND RELATED
paru -S --needed hyprshot vicinae-bin fnm pavucontrol grimblast-git

## LIGHT: desktop
# sudo pacman --noconfirm --needed -S ddcutil

## LIGHT: notebook
# paru -S --needed acpilight

## FONTS
sudo pacman --noconfirm --needed -S \
  ttf-iosevka-nerd ttf-jetbrains-mono-nerd noto-fonts-emoji \
  ttf-nerd-fonts-symbols  ttf-nerd-fonts-symbols-common \
  terminus-font noto-fonts ttf-liberation ttf-croscore

## BASIC
sudo pacman --noconfirm --needed -S \
  vi vim git github-cli nvim tmux stow zsh ripgrep fzf eza \
  tree-sitter tree-sitter-cli \
  nodejs npm unzip fd

# Fancy
sudo pacman --noconfirm --needed -S \
  lazygit git-delta csvlens yazi

### AMD SPECIFIC: REQUIRES MULTLIB TO BE ENABLED!
# https://wiki.archlinux.org/title/Official_repositories
# Default GitHub account
sudo pacman --needed -S \
  mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon


### DOCKER
# sudo pacman --needed -S docker docker-compose

## RUN:
# sudo systemctl edit systemd-networkd-wait-online.service

## ADD:
# [Service]
# ExecStart=
# ExecStart=/usr/lib/systemd/systemd-networkd-wait-online --any

## ADD THE USER
# sudo groupadd docker
# sudo usermod -aG docker $USER
