#!/bin/bash

WALLPAPER_DIR="$HOME/.config/wallpapers/"
# CURRENT_WALL=$(hyprctl hyprpaper listloaded)

# Get a random wallpaper that is not the current one
WALLPAPER=$(find "$WALLPAPER_DIR" -type f -regex ".*\.\(png\|jpg\|jpeg\|webp\)" | shuf -n 1)

# Apply the selected wallpaper
hyprctl hyprpaper reload ,"$WALLPAPER"
