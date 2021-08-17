#!/bin/bash -v

##### INSTALL PKGS
sudo pacman --noconfirm --needed -S \
    docker docker-compose nodejs npm \
    redis mariadb mysql-workbench \
    code openconnect gnome-keyring \
    seahorse aws-cli lua-language-server


# NPM Globals Installs
mkdir -p ~/.config/npm-global
npm config set prefix '~/.config/npm-global'

# Docker
sudo groupadd docker
sudo usermod -aG docker $USER

# NeoVIM LSP
npm install -g typescript typescript-language-server
yarn global add diagnostic-languageserver

# Python LSP
pip install 'python-lsp-server[all]'
pip install pylint

# Rust
if ! command -v rustc &> /dev/null
then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
  rustup component add rls rust-analysis rust-src
fi
if ! command -v rust-analyzer &> /dev/null
then
  mkdir -p $HOME/.local/bin
  curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o ~/.local/bin/rust-analyzer
  chmod +x ~/.local/bin/rust-analyzer
fi
