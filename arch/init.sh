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
stow bash


#### Check for TPM
[ ! -d "$HOME/.tmux/plugins/tpm" ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#### Setup Defaults
xdg-mime default firefox.desktop x-scheme-handler/http
xdg-mime default firefox.desktop x-scheme-handler/https
xdg-settings set default-web-browser firefox.desktop


#### EMACS
if [[ ! -d "$HOME/.doom-emacs" ]] ; then
    git clone --depth 1 https://github.com/hlissner/doom-emacs ~/.doom-emacs
    ~/.doom-emacs/bin/doom install
fi

#### GIT Store
git config --global credential.helper store
git config --global core.excludesFile '~/.config/.git-ignore'

#### Copy Fonts
sudo cp fonts/* /usr/share/fonts/

#### Installing yay
if ! command -v yay &> /dev/null
then
    git clone https://aur.archlinux.org/yay.git ~/yay
    cd ~/yay
    makepkg -si
    exit
fi
