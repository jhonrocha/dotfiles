#!/bin/bash -v

### Get the repo
[ ! -d "~/dotfiles" ] && git clone https://github.com/jhonrocha/dotfiles.git ~/dotfiles
### Go to the repo
cd /data/dotfiles > /dev/null 2>&1 || cd ~/dotfiles
##### INSTALL PKGS
sudo pacman --noconfirm --needed -S - < pkg-all.txt

#### Installing yay
if ! command -v yay &> /dev/null
then
    git clone https://aur.archlinux.org/yay.git ~/yay
    cd ~/yay
    makepkg -si
fi

### Install from AUR
cd /data/dotfiles/arch > /dev/null 2>&1 || cd ~/dotfiles/arch
yay -S --answerclean None --answerdiff None --answeredit None --noprovides --norebuild --needed - < pkg-aur.txt

#### STOW THE PACKAGES
./stowing.sh

### Install i3
./i3-init.sh

#### Check for TPM
[ ! -d "$HOME/.tmux/plugins/tpm" ] && git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

#### Setup Defaults
xdg-mime default brave-broswer.desktop  x-scheme-handler/http
xdg-mime default brave-browser.desktop x-scheme-handler/https
xdg-settings set default-web-browser brave-browser.desktop

# xdg-mime default vivaldi-stable.desktop  x-scheme-handler/http
# xdg-mime default vivaldi-stable.desktop x-scheme-handler/https
# xdg-settings set default-web-browser vivaldi-stable.desktop
xdg-mime default org.pwmt.zathura.desktop application/pdf

#### GIT Store
git config --global credential.helper store
git config --global core.excludesFile '~/.config/.git-ignore'

##### Setting audio
amixer sset Master unmute
amixer sset Speaker unmute
amixer sset Headphone unmute
