#!/bin/bash -v

##### INSTALL PKGS
sudo pacman --noconfirm --needed -S - < pkg-all.txt

#### STOW THE PACKAGES
cd ~/dotfiles
stow doom
stow editor
stow emacs
stow fd
stow fish
stow git-config
stow gtk
stow ranger
stow scripts
stow starship
stow tmux
stow vim
stow vifm
stow bash

#### Installing yay
if ! command -v yay &> /dev/null
then
    git clone https://aur.archlinux.org/yay.git ~/yay
    cd ~/yay
    makepkg -si
    exit
fi

yay brave-broswer

#### Check for TPM
[ ! -d "$HOME/.tmux/plugins/tpm" ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#### Setup Defaults
xdg-mime default brave-broswer.desktop  x-scheme-handler/http
xdg-mime default brave-browser.desktop x-scheme-handler/https
xdg-settings set default-web-browser brave-browser.desktop


#### EMACS
if [[ ! -d "$HOME/.doom-emacs" ]] ; then
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.doom-emacs
    ~/.doom-emacs/bin/doom install
fi

#### GIT Store
git config --global credential.helper store
git config --global core.excludesFile '~/.config/.git-ignore'


