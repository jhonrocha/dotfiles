#!/bin/sh
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap
# merge in defaults and keymaps
if [ -f $sysresources ]; then
  xrdb -merge $sysresources
fi
if [ -f $sysmodmap ]; then
  xmodmap $sysmodmap
fi
if [ -f "$userresources" ]; then
  xrdb -merge "$userresources"
fi
if [ -f "$usermodmap" ]; then
  xmodmap "$usermodmap"
fi
# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi
# profile
[ -f /etc/xprofile ] && . /etc/xprofile
[ -f ~/.xprofile ] && . ~/.xprofile
eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK
case $WM in
    i3 )
      exec i3
      ;;
    awesome )
      sxhkd &
      exec awesome
      ;;
    bspwm )
      sxhkd &
      exec bspwm
      ;;
    spectrwm )
      sxhkd &
      exec spectrwm
      ;;
    xmonad )
      exec xmonad;;
    dwm )
      killall dwmbar
      dwmbar &
      sxhkd &
      exec dwm
      ;;
    * )
      exec xmonad;;
esac
