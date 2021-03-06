[ -f ~/.profile ] && . "$HOME"/.profile
[ -f ~/.config/.prvenvs ] && . ~/.config/.prvenvs

# Functions
init-i3 () {
  export WM=i3
  exec startx >> ~/.cache/xinit.log 2>&1
}
init-xmonad () {
  export WM=xmonad
  exec startx >> ~/.cache/xinit.log 2>&1
}
init-sway () {
  export WM=sway
  export MOZ_ENABLE_WAYLAND=1
  exec sway --my-next-gpu-wont-be-nvidia >> ~/.cache/sway.log 2>&1
}

machine=$(uname -n)
if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  if [ $machine = "tiamat" ]; then
    # init-sway
    init-i3
  elif [ $machine = "think" ]; then
    init-i3
  fi
else
  [ -f ~/.bashrc ] && . "$HOME"/.bashrc
fi
