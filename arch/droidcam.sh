#!/bin/bash -v

##### INSTALL PKGS
sudo pacman --noconfirm --needed -S \
    v4l-utils v4l2loopback-dkms linux-headers \
    android-tools

yay droidcam
