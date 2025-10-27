[ -f ~/.profile ] && . "$HOME"/.profile

# Functions
init-i3 () {
  export WM=i3
  exec startx >> ~/.cache/xinit.log 2>&1
}
init-sway () {
  # eval $(gnome-keyring-daemon --start --components="pkcs11,secrets,ssh")
  # export SSH_AUTH_SOCK
  # export MOZ_ENABLE_WAYLAND=1
  # export WLR_RENDERER=vulkan
  # export WLR_NO_HARDWARE_CURSORS=1
  # export XWAYLAND_NO_GLAMOR=1
  export SDL_VIDEODRIVER=wayland
  export _JAVA_AWT_WM_NONREPARENTING=1
  export QT_QPA_PLATFORM=wayland
  export XDG_CURRENT_DESKTOP=sway
  export XDG_SESSION_DESKTOP=sway
  exec sway >> ~/.cache/sway.log 2>&1
}

machine=$(uname -n)
if [[ -x "$(command -v systemctl)" ]] && systemctl -q is-active graphical.target && [[ ! $DISPLAY && ! $WAYLAND_DISPLAY && $XDG_VTNR -eq 1 ]]; then
  if [ $machine = "tiamarch" ]; then
    init-sway
  elif [ $machine = "drogon" ]; then
    init-i3
  fi
else
  [ -f ~/.bashrc ] && . "$HOME"/.bashrc
fi
