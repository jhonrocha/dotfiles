#!/bin/bash
#     _  ____               _
#    | ||  _ \  ___    ___ | |__    __ _
# _  | || |_) |/ _ \  / __|| '_ \  / _` |
#| |_| ||  _ <| (_) || (__ | | | || (_| |
# \___/ |_| \_\\___/  \___||_| |_| \__,_|

##### AUR: YAY
if ! [ -x "$(command -v yay)" ]; then
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
  cd ..
  rm -r yay
fi

##### INSTALLATIONS
yay vpn-slice
yay spotify
yay font-manager
yay vivaldi
