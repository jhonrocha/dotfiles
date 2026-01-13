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
    waybar  swww  ghostty  \
    pipewire wireplumber \
    nemo nemo-fileroller nemo-compare nemo-terminal


# HYPRLAND RELATED
paru -S --needed hyprshot vicinae-bin fnm pavucontrol

# Basic
sudo pacman --noconfirm --needed -S \
  git github-cli nvim tmux stow zsh ripgrep fzf eza \
  ttf-iosevka-nerd ttf-jetbrains-mono-nerd noto-fonts-emoji \
  tree-sitter tree-sitter-cli terminus-font \
  nodejs npm

# Fancy
sudo pacman --noconfirm --needed -S \
  lazygit git-delta

### AMD SPECIFIC: REQUIRES MULTLIB TO BE ENABLED!
# https://wiki.archlinux.org/title/Official_repositories
# Default GitHub account
sudo pacman --needed -S \
  mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon
