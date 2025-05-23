#!/bin/bash -v

### Get the repo
[ ! -d "~/dotfiles" ] && git clone https://github.com/jhonrocha/dotfiles.git ~/dotfiles
### Go to the repo
cd ~/dotfiles
##### INSTALL PKGS
sudo pacman --noconfirm --needed -S - < pkg-all.txt

#### Installing paru
if ! command -v paru &> /dev/null
then
  sudo pacman -S --needed base-devel
  git clone https://aur.archlinux.org/paru.git
  cd paru
  makepkg -si
fi

cd ~/dotfiles/

#### STOW THE PACKAGES
./stowing.sh

#### Setup Defaults
xdg-mime default google-chrome.desktop  x-scheme-handler/http
xdg-mime default google-chrome.desktop x-scheme-handler/https
BROWSER= && xdg-settings set default-web-browser google-chrome.desktop
xdg-mime default org.pwmt.zathura.desktop application/pdf

#### GIT Store
git config --global credential.helper store
git config --global core.excludesFile '~/.config/.git-ignore'
