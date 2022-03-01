#!/bin/bash -v

rm ~/.bash*
cd /data/dotfiles
stow editor -t ~/
stow fd -t ~/
stow git-config -t ~/
stow gtk -t ~/
stow rofi -t ~/
stow scripts -t ~/
stow starship -t ~/
stow tmux -t ~/
stow vim -t ~/
stow ranger -t ~/
stow bash -t ~/
stow zsh -t ~/
stow doom -t ~/
stow kitty -t ~/
stow redshift -t ~/


