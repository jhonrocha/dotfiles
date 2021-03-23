# Load Profile
[ -f ~/.profile ] && . ~/.profile
[ -f ~/.config/.rauxa_envs ] && . ~/.config/.rauxa_envs

if systemctl -q is-active graphical.target && [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  XTERM=$TERMINAL
  TERMCMD=$TERMINAL
  export WM=xmonad
  exec startx >> ~/.cache/xinit.log 2>&1
fi

# Enable colors and change prompt:
autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}["
PS1+="%{$fg[yellow]%}%n"
PS1+="%{$fg[green]%}@"
PS1+="%{$fg[blue]%}%M "
PS1+="%b%{$fg[magenta]%}%2d"
PS1+="%{$fg[red]%}]"
PS1+="%{$reset_color%}$ "
[ -n "$NNNLVL" ] && PS1="N$NNNLVL $PS1"
export PS1
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.

# History in cache directory:
HISTSIZE=99999
SAVEHIST=99999
HISTFILE=~/.cache/.zsh_history
setopt SHARE_HISTORY

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select 
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
zmodload zsh/complist
setopt COMPLETE_ALIASES
compinit
_comp_options+=(globdots)

# vi mode
bindkey -v
export KEYTIMEOUT=1

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


# fzf support
[ -f /usr/share/fzf/key-bindings.zsh ] && . /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && . /usr/share/fzf/completion.zsh
# Run neofetch
if [ -z "$TMUX" ]; then
  [ -f ~/.cache/wal/sequences ] && (cat ~/.cache/wal/sequences &)
  neofetch
fi

source /home/jh/.config/broot/launcher/bash/br
