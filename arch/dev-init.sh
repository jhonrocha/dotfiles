#!/bin/bash -v

##### INSTALL PKGS
sudo pacman --noconfirm --needed -S \
    docker docker-compose nodejs npm \
    redis mariadb mysql-workbench \
    code openconnect gnome-keyring \
    seahorse aws-cli

sudo groupadd docker
sudo usermod -aG docker $USER
