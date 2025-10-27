#!/bin/bash

WALLPAPER_DIR="$HOME/.config/wallpapers/"
CURRENT="$HOME/.config/wallpapers/current"

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f -regex ".*\.\(png\|jpg\|jpeg\|webp\)" | shuf -n 1)

# Apply the selected wallpaper
# hyprctl hyprpaper reload ,"$WALLPAPER"
# swww img $WALLPAPER --transition-type center
swaybg -i $WALLPAPER

# Make a symlink to current
ln -sf $WALLPAPER $CURRENT
