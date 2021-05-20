#!/bin/bash -v

cd ~/dotfiles/arch
##### INSTALL PKGS
sudo pacman --noconfirm --needed -S - < pkg-all.txt

#### Installing yay
if ! command -v yay &> /dev/null
then
    git clone https://aur.archlinux.org/yay.git ~/yay
    cd ~/yay
    makepkg -si
fi

cd ~/dotfiles/arch
yay -S --answerclean None --answerdiff None --answeredit None --noprovides --norebuild --needed - < pkg-aur.txt

#### Devlopment Stack
./dev-init.sh

#### STOW THE PACKAGES
cd ~/dotfiles
stow doom
stow editor
stow emacs
stow fd
stow fish
stow git-config
stow gtk
stow rofi
stow scripts
stow starship
stow tmux
stow vim
stow vifm
stow bash
stow zsh
stow kitty

#### Check for TPM
[ ! -d "$HOME/.tmux/plugins/tpm" ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#### Setup Defaults
xdg-mime default brave-broswer.desktop  x-scheme-handler/http
xdg-mime default brave-browser.desktop x-scheme-handler/https
xdg-settings set default-web-browser brave-browser.desktop
xdg-mime default org.pwmt.zathura.desktop application/pdf

#### GIT Store
git config --global credential.helper store
git config --global core.excludesFile '~/.config/.git-ignore'


# ##### PIP Install
sudo pip3 install pygobject

##### Setting audio
amixer sset Master unmute
amixer sset Speaker unmute
amixer sset Headphone unmute
