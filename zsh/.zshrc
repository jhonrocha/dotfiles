[ -f ~/.profile ] && . ~/.profile

# Lines configured by zsh-newuser-install
HISTSIZE=500000
SAVEHIST=500000
# History in cache directory:
setopt appendhistory
setopt INC_APPEND_HISTORY
setopt SHARE_HISTORY
setopt autocd notify
unsetopt beep extendedglob
# vi mode
bindkey -v
export KEYTIMEOUT=1
# End of lines configured by zsh-newuser-install

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

init-hyprland () {
  export SDL_VIDEODRIVER=wayland
  export _JAVA_AWT_WM_NONREPARENTING=1
  export QT_QPA_PLATFORM=wayland
  export XDG_CURRENT_DESKTOP=Hyprland
  export XDG_SESSION_DESKTOP=Hyprland
  exec Hyprland >> ~/.cache/hyprland.log 2>&1
}

machine=$(uname -n)
if [[ ! $DISPLAY && (($XDG_VTNR -eq 1)) ]]; then
  if [ $machine = "tiamat" ]; then
    init-hyprland
  elif [ $machine = "drogon" ]; then
    init-hyprland
  fi
elif [[ ! $DISPLAY && (($XDG_VTNR -eq 2)) ]]; then
  init-sway
fi

# Enable colors and change prompt:
autoload -U colors && colors
stty stop undef		# Disable ctrl-s to freeze terminal.

autoload -U +X bashcompinit && bashcompinit

# The following lines were added by compinstall
zstyle :compinstall filename '/home/jh/.zshrc'
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
zmodload zsh/complist
setopt COMPLETE_ALIASES
compinit
_comp_options+=(globdots)

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey  "^[[1~"   beginning-of-line
bindkey  "^[[3~"  delete-char
bindkey  "^[[4~"   end-of-line
bindkey  "^[[H"   beginning-of-line
bindkey  "^[[F"   end-of-line

# Suggestions and Highliting
[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
bindkey '^ ' autosuggest-accept

# Zsh fzf support
if  command -v fzf &> /dev/null
then
  source <(fzf --zsh)
fi
# # McFly
# if  command -v mcfly &> /dev/null
# then
#   export MCFLY_LIGHT=FALSE
#   export MCFLY_KEY_SCHEME=vim
#   export MCFLY_FUZZY=2
#   eval "$(mcfly init zsh)"
# fi

# Zsh Starship
precmd_functions=
if  command -v starship &> /dev/null
then
    eval "$(starship init zsh)"
fi


# .env
if [ -f ".env/bin/activate" ]; then . ".env/bin/activate"; fi
if [ -f ".venv/bin/activate" ]; then . ".venv/bin/activate"; fi

# bun completions
[ -s "/Users/jhon/.bun/_bun" ] && source "/Users/jhon/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

